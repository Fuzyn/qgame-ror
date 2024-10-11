Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, only: [:new, :create]

  get 'preview', to: 'preview#show', as: 'preview'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'shipyard', to: 'shipyard#index'
  post 'shipyard/build', to: 'shipyard#build', as: 'shipyard_build'

  get 'defence', to: 'defence#index'
  post 'defence/build', to: 'defence#build', as: 'defence_build'

  get 'building', to: 'buildings#index'
  post 'building/build', to: 'buildings#build', as: 'building_build'

  get 'technology', to: 'technology#index'
  post 'technology/build', to: 'technology#build', as: 'technology_build'

  match '*path', to: redirect('/404.html'), via: :all
end
