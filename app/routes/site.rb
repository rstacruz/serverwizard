require 'script'
require 'script_bundle'

class Main
  get '/' do
    haml :home
  end

  post '/script' do
    redirect '/'  unless params[:recipes].to_s.size > 0
    redirect '/'  if params[:custom] && params[:custom].any? && params[:custom].any? { |k, v| v.to_s.empty? }

    @url     = script_url(params[:recipes], params[:custom])
    @tar_url = script_url(params[:recipes], params[:custom], :tarball)

    @command = "sudo bash < <(wget \"#{@url}\" -q -O -)"

    haml :script
  end

  get '/script/*' do |recipes|
    params.delete 'splat'
    recipes = recipes.split(' ')

    content_type :txt
    bundle(recipes, params).build
  end

  get '/tarball/*' do |recipes|
    params.delete 'splat'
    recipes = recipes.split(' ')

    content_type "application/x-tar"
    attachment "#{recipes.join('+')}.tar.gz"
    bundle(recipes, params).tarball
  end

  helpers do
    def script_url(recipes, custom, type='script')
      url  = "http://#{request.env['HTTP_HOST']}/#{type}/" + recipes.join('+')
      url += kv(custom)
      url
    end

    def bundle(recipes, custom)
      ScriptBundle.new recipes, custom, request.env['HTTP_HOST']
    end

    def kv(hash)
      return ""  unless hash.is_a?(Hash) && hash.any?

      "?" + hash.map { |k, v| "#{Rack::Utils.escape k}=#{Rack::Utils.escape v}" }.join("&")
    end
  end
end

