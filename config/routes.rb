Rails.application.routes.draw do
  root 'sessions#new'
  resources :users, only: [:new, :create]

  get 'preview', to: 'preview#index', as: 'preview'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'change_planet/:id', to: 'application#change_planet'

  get 'shipyard', to: 'shipyard#index'
  post 'shipyard/build', to: 'shipyard#build', as: 'shipyard_build'

  get 'defence', to: 'defence#index'
  post 'defence/build', to: 'defence#build', as: 'defence_build'

  get 'building', to: 'buildings#index'
  post 'building/build', to: 'buildings#build', as: 'building_build'

  get 'technology', to: 'technology#index'
  post 'technology/build', to: 'technology#build', as: 'technology_build'

  get 'galaxy', to: 'galaxy#index'
  post 'add_fleet', to: 'galaxy#add_fleet', as: 'add_galaxy_fleet'
  post 'send_galaxy_fleet', to: 'galaxy#send_galaxy_fleet', as: 'send_galaxy_fleet'

  get 'fleet', to: 'fleet#index'
  post 'add_mission', to: 'fleet#add_mission', as: 'add_mission'
  post 'send_fleet', to: 'fleet#send_fleet', as: 'send_fleet'

  get 'messages', to: 'messages#index'
  post 'mark_as_read/:id', to: 'messages#mark_as_read', as: 'mark_as_read'

  get 'empire', to: 'empire#index'

  get 'resources', to: 'resources#index'

  get 'trader', to: 'trader#index'
  post 'exchange', to: 'trader#exchange', as: 'exchange'

  post 'planet_name', to: 'planets#planet_name', as: 'planet_name'
  post 'change_name', to: 'planets#change_name', as: 'change_name'

  get 'alliance', to: 'alliance#index'
  get 'new', to: 'alliance#new', as: 'new_alliance'
  post 'create', to: 'alliance#create', as: 'create_alliance'
  get 'search', to: 'alliance#search', as: 'search_alliance'
  post 'join/:id', to: 'alliance#join', as: 'join_alliance'
  post 'leave', to: 'alliance#leave', as: 'leave_alliance'

  match '*path', to: redirect('/404.html'), via: :all
end
