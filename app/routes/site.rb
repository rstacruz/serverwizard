require 'script'
require 'script_bundle'

class Main
  get '/' do
    haml :home
  end

  post '/script' do
    redirect '/'  unless params[:recipes].to_s.size > 0
    redirect '/'  if params[:custom] && params[:custom].any? && params[:custom].any? { |k, v| v.to_s.empty? }

    url  = "http://#{request.env['HTTP_HOST']}/script/" + params[:recipes].join('+')
    url += kv(params[:custom])

    @url = url
    @command = "sudo bash < <(wget \"#{url}\" -q -O -)"
    @contents = build_script(params[:recipes], params[:custom])

    haml :script
  end

  get '/script/*' do |recipes|
    params.delete 'splat'
    content_type :txt

    recipes = recipes.split(' ')

    build_script recipes, params
  end

  helpers do
    def build_script(recipes, custom)
      ScriptBundle.build(recipes, custom, request.env['HTTP_HOST'])
    end

    def kv(hash)
      return ""  unless hash.is_a?(Hash) && hash.any?

      "?" + hash.map { |k, v| "#{Rack::Utils.escape k}=#{Rack::Utils.escape v}" }.join("&")
    end
  end
end

