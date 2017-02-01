Rails.application.routes.draw do
  get 'test/index'

  get 'home/index'

  resources :collections
  resources :items
  resources :users
  
  resources :schemas do
    member do
      get '/instance(/collection/:collectionId)', to: 'schemas#create_schema_instance'
    end
  end

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	
	devise_scope :user do
		get 'sign_out', :to => 'devise/sessions#destroy', as: :destroy_user_session
	end
	
end
