require 'digest/sha1'

class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :text, :type => String
end