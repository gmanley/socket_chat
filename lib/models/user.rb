require 'digest/sha2'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected :password_hash, :password_salt
  attr_accessor :password, :password_confirmation

  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :password_hash, type: String
  field :password_salt, type: String

  after_initialize :prepare_password

  EMAIL_REGEX = /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  validates :password, presence: true,
                       confirmation: true

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: EMAIL_REGEX }

  has_many :messages
  has_and_belongs_to_many :rooms

  def short_name
    "#{first_name[0]}.#{last_name}".downcase
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(email, password)
    user = first(conditions: {email: email})
    return user if user and user.matching_password?(password)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private
  def prepare_password
    unless password.blank?
      self.password_salt = SecureRandom.urlsafe_base64
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    Digest::SHA512.hexdigest([pass, password_salt].join)
  end
end