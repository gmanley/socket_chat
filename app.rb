module SocketChat
  class App < Sinatra::Base

    configure(:development) do |c|
      register Sinatra::Reloader
      c.also_reload('lib/**/*.rb')
    end

    configure(:production) do
      SocketChat.setup_airbrake unless config.airbrake_api_key.nil?
      set :haml, {ugly: true}
    end

    configure(:production, :development) do
      enable(:logging, :dump_errors)
    end

    configure do
      set :root, APP_ROOT
      set :config, SocketChat.config
      set :haml, {format: :html5}

      enable(:sessions)
      set :session_secret, config.session_secret
      use Rack::Flash
    end

    helpers(ApplicationHelper)

    get '/' do
      @messages = Message.limit(20)
      haml :index
    end

    get '/lobby' do
      @rooms = Room.accessible_by(current_user)
      haml :lobby
    end

    get '/rooms/:room_name' do |room_name|
      if @room = Room.find_by_slug(room_name)
        if @room.accessible_by?(current_user)
          @messages = @room.messages.limit(20)
          haml :room
        else
          403
        end
      else
        404
      end
    end

    post '/user/login' do
      if user = User.authenticate(params[:email], params[:password])
        flash.now[:notice] = "Logged in successfully"
        session[:user_id] = user.id.to_s
        redirect '/lobby'
      else
        flash.now[:notice] = "Incorrect credentials"
        redirect '/'
      end
    end

    get '/user/new' do
      haml :register
    end

    post '/user/new' do
      @user = User.create(params)
      if @user.valid?
        flash[:notice] = "Registered successfully!"
        session[:user_id] = @user.id.to_s
        redirect '/'
      else
        haml :register
      end
    end

    get '/user/logout' do
      session[:user_id] = nil
      redirect '/'
    end

   error 403 do
     haml :'403'
   end

    not_found do
      haml :'404'
    end
  end
end
