Rails.application.routes.draw do
  get 'user/show'
  get 'static_pages/instructions'
  devise_for :users
  resources :tasks
  get '/page_use', to: 'static_pages#instructions', as: 'instructions'
  get '/profile', to: 'user#show', as: 'profile'
  root 'tasks#index'
end
