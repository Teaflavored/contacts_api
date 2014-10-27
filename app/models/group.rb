# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Group < ActiveRecord::Base
  validates :name, :user_id, presence: true
  belongs_to :user
  has_many :contact_groups
  has_many :contacts, through: :contact_groups
end
