require File.dirname(__FILE__) + '/../../models/user.rb'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
 
  def google_oauth2 
    @user = User.from_omniauth(request.env["omniauth.auth"], current_user)
    if @user 
      update_user
      sign_in_and_redirect @user, :event => :authentication
    else 
      redirect_to root_url
    end
	end

  private

  def update_user
    @user.update({
      name: request.env["omniauth.auth"][:info][:name],
      image_url: request.env["omniauth.auth"][:info][:image],
      last_log: Time.new
    })
  end

end
