class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end
  
  def index
    if params[:user_id]
      render json: User.find(params[:user_id]).comments
    elsif params[:contact_id]
      render json: Contact.find(params[:contact_id]).comments
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end