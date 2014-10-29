class SessionsController < ApplicationController
	def new
		render :new
	end

	def create
		@user = User.find_by_credentials(
			params[:user][:username],
			params[:user][:password]
			)
		if @user.nil?
			redirect_to new_session_url
		else
			log_in(@user)
			redirect_to user_url(@user)
		end
	end

	def destroy
	end
end
