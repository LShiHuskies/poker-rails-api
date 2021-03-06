Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users
    resources :game_rooms
    resources :sessions
    resources :messages
  end

  mount ActionCable.server => '/cable'
end
