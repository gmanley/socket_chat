module SocketChat::ApplicationHelper
  def faye_path
    "#{request.scheme}://#{request.host}:9001/faye"
  end

  def faye_js_path
    faye_path + ".js"
  end

  def room_url(room)
    "#{request.scheme}://#{request.host}:#{request.port}/room/#{room}"
  end

  def logged_in?
    !session[:user].nil? && current_user
  end

  def current_user
    User.find(session[:user])
  end

  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << haml(:"#{template}", options.merge(:layout => false, :locals => {template_array[-1].to_sym => member}))
      end.join("\n")
    else
      haml(:"#{template}", options)
    end
  end
end