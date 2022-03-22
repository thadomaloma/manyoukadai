Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only: [:new, :create, :index]

  namespace :admin do
    resources :users, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end
end
