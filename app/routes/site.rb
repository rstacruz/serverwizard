require 'recipe'
require 'bundle'

class Main
  get '/' do
    haml :home
  end

  post '/script' do
    redirect '/'  unless params[:recipes].to_s.size > 0
    redirect '/'  if params[:custom] && params[:custom].any? && params[:custom].any? { |k, v| v.to_s.empty? }

    @bundle = bundle(params[:recipes], params[:custom])

    customs = @bundle.non_default_customs

    @url     = script_url(params[:recipes], customs)
    @tar_url = script_url(params[:recipes], customs, :tarball)
    @sh_url  = script_url(params[:recipes], customs, :script_download)

    @command = "sudo bash < <(wget \"#{@url}\" -q -O -)"

    haml :script
  end

  get '/:type/*' do |type, recipes|
    pass  unless %w(script script_download tarball).include?(type)

    params.delete 'splat'
    params.delete 'type'
    recipes = recipes.split(' ')
    @script = bundle(recipes, params)

    case type
    when "script"
      content_type :txt
      @script.build

    when "script_download"
      content_type :txt
      attachment "#{recipes.join('+')}.sh"
      @script.build

    when "tarball"
      content_type "application/x-tar"
      attachment "#{recipes.join('+')}.tar.gz"
      @script.tarball
    end
  end

  get '/remote.sh' do
    send_file Main.root('data/tarball/remote.sh')
  end

  helpers do
    def script_url(recipes, custom, type='script')
      url  = "http://#{request.env['HTTP_HOST']}/#{type}/" + recipes.join('+')
      url += kv(custom)
      url
    end

    def bundle(recipes, custom)
      Bundle.new recipes, custom, request.env['HTTP_HOST']
    end

    def kv(hash)
      return ""  unless hash.is_a?(Hash) && hash.any?

      "?" + hash.map { |k, v| "#{Rack::Utils.escape k}=#{Rack::Utils.escape v}" }.join("&")
    end
  end
end

