Rails.application.routes.draw do
  get 'static_pages/instructions'
  devise_for :users
  resources :users, only: [:index]
  resources :tasks
  get '/page_use', to: 'static_pages#instructions', as: 'instructions'
  root 'tasks#index'
end
