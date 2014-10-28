class ContactGroupsController < ApplicationController
  def create
    @contact_group = ContactGroup.new(contact_group_params)
    if @contact_group.save
      redirect_to group_contacts_url(@contact_group.group_id)
    else
      flash.notice = @contact_group.errors.full_messages
      redirect_to contact_url(@contact_group.contact_id)
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