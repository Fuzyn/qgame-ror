Rails.application.routes.draw do
  root :to => 'sessions#new'
  resources :users, only: [:new, :create]

  get 'preview', to: 'preview#show', as: 'preview'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
