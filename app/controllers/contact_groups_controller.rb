class ContactGroupsController < ApplicationController
  def create
    contact_group = ContactGroup.new(contact_group_params)
    if contact_group.save
      render json: contact_group
    else
      render json: contact_group.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    contact_group = ContactGroup.find(params[:id])
    contact_group.destroy
    render json: contact_group
  end
  
  private
  
  def contact_group_params
    params.require(:contact_group).permit(:contact_id, :group_id)
  end
end