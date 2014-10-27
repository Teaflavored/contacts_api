class GroupsController < ApplicationController
  def index
    render json: User.find(params[:user_id]).groups
  end
  
  def create
    group = Group.new(group_params)
    if group.save
      render json: group
    else
      render json: group.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    group = Group.find(params[:id])
    group.destroy
    render json: group
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :user_id)
  end
end