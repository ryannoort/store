class User < ApplicationRecord
	has_many :items
	has_many :collections
	# has_many :schemas

	enum role: {
		admin: 0,
		editor: 1,
		user: 2
	} unless instance_methods.include? :admin?

	devise :omniauthable, :omniauth_providers => [:google_oauth2]
	
	def self.from_omniauth(access_token, signed_in_resource=nil)
		data = access_token.info
		user = User.where(:email => data["email"]).first
	end

end
