class User < ApplicationRecord

	enum role: [:admin, :editor, :user] unless instance_methods.include? :role

	devise :omniauthable, :omniauth_providers => [:google_oauth2]
	
	def self.from_omniauth(access_token, signed_in_resource=nil)
		data = access_token.info
		user = User.where(:email => data["email"]).first
	end

end
