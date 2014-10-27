class ContactsController < ApplicationController
  def index
    if params[:group_id]
      render json: Group.find(params[:group_id]).contacts
    else
      own_contacts = User.find(params[:user_id]).contacts
      shared_contacts = User.find(params[:user_id]).shared_contacts
      render json: own_contacts + shared_contacts
    end
  end
  
  
  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end
  
  def show
    render json: Contact.find(params[:id])
  end
  
  private
  def contact_params
    params.require(:contact).permit(:user_id, :email, :name)
  end
end