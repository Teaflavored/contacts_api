# == Schema Information
#
# Table name: contact_groups
#
#  id         :integer          not null, primary key
#  contact_id :integer          not null
#  group_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class ContactGroup < ActiveRecord::Base
  validates :contact_id, :group_id, presence: true
  validates :contact_id, uniqueness: { scope: :group_id }
  
  belongs_to :group
  belongs_to :contact
end
