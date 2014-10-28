class ContactsController < ApplicationController
  def index
    if params[:group_id]
      @user = Group.find(params[:group_id]).user
      @group_contacts = Group.find(params[:group_id]).contacts
    else
      @contact = Contact.new
      @user = User.find(params[:user_id])
      @own_contacts = User.find(params[:user_id]).contacts
      @shared_contacts = User.find(params[:user_id]).shared_contacts
    end
  end
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to user_contacts_url(@contact.owner)
    else
      @user = User.find(@contact.user_id)
      flash.notice = @contact.errors.full_messages
      redirect_to user_contacts_url(@user)
    end
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to @contact
    else
      flash.notice = @contact.errors.full_messages
    end
  end

  def edit
    @contact = Contact.find(params[:id])
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @user = @contact.owner
    @contact.destroy
    redirect_to user_contacts_url(@user)
  end
  
  def show
    @contact = Contact.find(params[:id])
    @user_groups = @contact.owner.groups
  end
  
  def favorite
    user = User.find(params[:user_id])
    contact = Contact.find(params[:contact_id])
    contact_share = ContactShare.find_by(:user_id => params[:user_id], :contact_id => params[:contact_id])
    if contact.user_id == user.id
      contact.favorite!
      redirect_to contact
    elsif contact_share
      contact_share.favorite!
      redirect_to contact_share.contact
    end
    
  end
  
  private
  def contact_params
    params.require(:contact).permit(:user_id, :email, :name)
  end
end