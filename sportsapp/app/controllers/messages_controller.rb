class MessagesController < ApplicationController
  def create
  	# create holder for message
  	message = params[:body]
  	# get all users
  	users = User.all
  	# message each user
  	users.each do |user|
  		user.send_sms(message)
  	end
  	flash[:notice] = "Message away!!!"
  	redirect_to user_path(current_user)
  end
end
