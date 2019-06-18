Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :tasks do
    post :update_multiple, on: :collection
  end
  root 'tasks#index'
end
