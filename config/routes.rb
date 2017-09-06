Rails.application.routes.draw do
  # root 'static_pages#index'

  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'dashboard', to: 'users#show'

  resources :logs, only: [:index, :show]
end
