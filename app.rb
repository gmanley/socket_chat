require 'yaml'

module SocketChat
  class App < Sinatra::Base

    # def self.setup_db(config)
    #   Mongoid.configure do |mongoid_config|
    #     if mongodb_url = (ENV['MONGOHQ_URL'] || ENV['MONGOLAB_URI']) # For heroku deploys
    #       conn = Mongo::Connection.from_uri(mongodb_url)
    #       mongoid_config.master = conn.db(URI.parse(mongodb_url).path.gsub(/^\//, ''))
    #     else
    #       mongoid_config.from_hash(config["database"][settings.environment.to_s])
    #     end
    #   end
    # end

    configure(:production) do
      set :haml, {:ugly => true}
    end

    configure(:production, :development) do
      enable(:logging, :dump_errors)
    end

    configure do
      set :haml, {:format => :html5}
      # config = YAML.load_file('config/config.yml')
      # setup_db(config)
    end

    helpers do
      def faye_path
        "#{request.scheme}://#{request.host}:9001/faye"
      end

      def faye_js_path
        faye_path + ".js"
      end

      def room_url(room)
        "#{request.scheme}://#{request.host}:#{request.port}/room/#{room}"
      end
    end

    def generate_room_hash
      Digest::MD5.hexdigest(Time.now.to_f.to_s).slice(0, 8)
    end

    get '/' do
      haml :index
    end
  end
end