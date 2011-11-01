require 'yaml'

module SocketChat
  class App < Sinatra::Base

    def self.setup_db(config)
      Mongoid.configure do |mongoid_config|
        if mongodb_url = (ENV['MONGOHQ_URL'] || ENV['MONGOLAB_URI']) # For heroku deploys
          conn = Mongo::Connection.from_uri(mongodb_url)
          mongoid_config.master = conn.db(URI.parse(mongodb_url).path.gsub(/^\//, ''))
        else
          mongoid_config.from_hash(config["database"][settings.environment.to_s])
        end
      end
      require 'lib/user'
      require 'lib/message'
      require 'lib/chat_history'
    end

    configure(:production) do
      set :haml, {:ugly => true}
    end

    configure(:production, :development) do
      enable(:logging, :dump_errors)
    end

    configure do
      config = YAML.load_file('config/config.yml')

      set :haml, {:format => :html5}

      enable(:sessions)
      set :session_secret, config['session_secret']
      use Rack::Flash

      setup_db(config)
    end

    require 'lib/application_helper'
    helpers(ApplicationHelper)

    get '/' do
      haml :index
    end

    post '/user/login' do
      if user = User.authenticate(params[:email], params[:password])
        flash[:notice] = "Logged in successfully"
        session[:user] = user.id.to_s
        redirect '/'
      else
        flash[:notice] = "Incorrect credentials"
        redirect '/'
      end
    end

    get '/user/logout' do
      session[:user] = nil
      redirect '/'
    end
  end
end