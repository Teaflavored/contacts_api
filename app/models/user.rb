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
  validates :username, presence: true, uniqueness: true
  
  has_many :comments, as: :commentable
  has_many :groups
  
  
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

