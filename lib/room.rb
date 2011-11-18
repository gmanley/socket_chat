class Room
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String

  slug :name
  has_many :messages

  validates_uniqueness_of :name, case_sensitive: false
end