Rails.application.routes.draw do
  devise_for :users
  resources :games, only: [ :index, :show, :new, :create ]
  root to: 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
