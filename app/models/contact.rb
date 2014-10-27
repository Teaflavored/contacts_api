# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  favorited  :boolean          default(FALSE)
#

class Contact < ActiveRecord::Base
  validates :user_id, :name, presence: true
  validates :email, presence: true, :uniqueness => {:scope => :user_id}
  
  has_many :comments, as: :commentable
  has_many :contact_groups
  has_many :groups, through: :contact_groups

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  ) 
  
  has_many :contact_shares, dependent: :destroy
  
  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )
  def favorite!
    self.favorited = (favorited ? false : true)
    self.save!
  end

end
