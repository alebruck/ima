Rails.application.routes.draw do
  root to: 'home#index'

  mount ActionCable.server => '/cable'

  post :send_message, to: 'messages#create', as: :new_message

  get :signin, to: 'sessions#new', as: :new_user_session
  delete :signout, to: 'sessions#destroy', as: :destroy_user_session
  post :signin, to: 'sessions#create', as: :user_session
end
