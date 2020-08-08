Rails.application.routes.draw do
  
  root 'home#top'
  get 'top' => 'home#top'
  get 'home/about' => 'home#new'


  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update, :new]
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
