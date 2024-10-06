Rails.application.routes.draw do
  get 'defence/index'
  get 'fleet/show'
  root :to => 'sessions#new'
  resources :users, only: [:new, :create] do
    collection do
      get :resources
    end
  end
  resources :fleet, only: [:index]

  get 'preview', to: 'preview#show', as: 'preview'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'fleet', to: 'fleet#index'
  post 'fleet/build', to: 'fleet#build', as: 'fleet_build'

  get 'defence', to: 'defence#index'
  post 'defence/build', to: 'defence#build', as: 'defence_build'
end
