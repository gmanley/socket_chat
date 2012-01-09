# encoding: UTF-8

module ApplicationHelper
  include Haml::Helpers

  def faye_path
    "#{request.scheme}://#{request.host}:#{request.port}/faye"
  end

  def faye_js_path
    "#{faye_path}.js"
  end

  def room_url(room)
    "#{request.scheme}://#{request.host}:#{request.port}/rooms/#{room.slug}"
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

  def block_message(main_message, messages = [])
    haml_tag :div, class: "alert-message block-message error", data: {alert: 'alert'} do
      haml_tag 'a.close', href: '#'
      haml_tag :p, main_message
      haml_tag :ul do
        messages.each do |msg|
          haml_tag :li, msg
        end
      end
    end
  end

  def flash_messages
    # Why the hell is values private for rack-flash
    flash.send(:values).each do |name, msg|
      haml_tag :div, class: "alert-message #{name} fade in", data: {alert: 'alert'} do
        haml_tag 'a.close', '×', href: '#'
        haml_tag :p, msg
      end
    end
  end
end
