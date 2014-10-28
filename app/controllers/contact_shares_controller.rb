class ContactSharesController < ApplicationController
  def create
    @contact_share = ContactShare.new(contact_share_params)
    if @contact_share.save
      flash[:contact_notice] = ["Successfully shared!"]
      redirect_to contact_url(@contact_share.contact_id)
    else
      flash[:contact_notice] = @contact_share.errors.full_messages
      redirect_to contact_url(@contact_share.contact_id)
    end
  end
  
  def destroy
    contact_share = ContactShare.find(params[:id])
    contact_share.destroy
    render json: contact_share
  end
  
  
  private
  def contact_share_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end
end