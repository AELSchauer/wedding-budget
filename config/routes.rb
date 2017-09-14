Rails.application.routes.draw do
  root 'static_pages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'dashboard', to: 'users#show'

  resources :banks, only: [:index, :show], param: :mx_id do
    scope module: :banks do
      resources :login, only: [:index, :create]
      resources :authenticate, only: [:index, :create]
    end
  end

  namespace :dashboard do
    resources :banks, only: [:index, :update, :destroy]
  end

  resources :account_activation, only: [:show, :update]

  resources :logs, only: [:index, :show]
end
