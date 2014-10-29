# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  username   :string(255)      not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 4, allow_nil: true }
  validates :session_token, presence: true
  
  before_validation :ensure_session_token

  has_many :comments, as: :commentable
  has_many :groups

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return nil if @user.nil?
    return nil unless @user.is_password?(password)

    @user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token

  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
  has_many(
    :contacts,
    class_name: "Contact",
    foreign_key: :user_id,
    primary_key: :id
  ) 
  
  has_many :contact_shares
  
  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )

  def favorite_contacts
    favorite_contacts = []
    contacts.each do |contact|
      favorite_contacts << contact if contact.favorited?
    end
    
    shared_contacts.each do |contact|
      favorite_contacts << contact if contact.favorited?
    end
    favorite_contacts
  end
end

