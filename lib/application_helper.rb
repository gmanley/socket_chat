module SocketChat::ApplicationHelper
  def faye_path
    "#{request.scheme}://#{request.host}:#{request.port}/faye"
  end

  def faye_js_path
    faye_path + ".js"
  end

  def room_url(room)
    "#{request.scheme}://#{request.host}:#{request.port}/room/#{room}"
  end

  def logged_in?
    true if current_user
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"

    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)

    haml(template.to_sym, options)
  end
end