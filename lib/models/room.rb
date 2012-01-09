class Room
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String

  slug :name
  has_many :messages
  has_and_belongs_to_many :users

  validates_uniqueness_of :name, case_sensitive: false

  def accessible_by?(user)
    users.include?(user)
  end

  def self.accessible_by(user)
    all.select { |room| room.users.include?(user) }
  end
end