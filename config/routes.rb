Rails.application.routes.draw do

devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end


root 'homes#home'

get 'home/about' => 'homes#about' , as: 'about'

resources :users, only:[:show, :index, :edit, :update]

resources :books, only:[:show, :index, :edit, :update, :destroy, :create]

end
