require 'resque/server'

FeedEngine::Application.routes.draw do
  mount Resque::Server, :at => "/resque"

  root :to => "application#landing_page"

  resources :runs
  resources :routes, only: [:create, :show]

  get '/dashboard', to: 'application#index'

  match 'auth/twitter/callback', to: 'sessions#create'
  match 'auth/runkeeper/callback', to: 'registrations#create'
  match 'auth/mapmyfitness/callback', to: 'registrations#create'
  match 'auth/dailymile/callback', to: 'registrations#create'
  get '/connect', to: 'registrations#new', as: 'new_dm_account'
  post '/dm_connect', to: 'registrations#dm_connect'


  match '/dailymile/authorize', to: 'daily_mile#authorize'

  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'auth/failure', to: "application#landing_page"
  match 'post_to_twitter', to: "application#post_to_twitter"
  get '/user', to: 'application#request_user'
  get '/profile', to: 'users#show', as: 'profile'
  get '/activity/:id', to: 'activities#show', as: 'activity'

end
