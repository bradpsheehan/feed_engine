require 'resque/server'

FeedEngine::Application.routes.draw do
  mount Resque::Server, :at => "/resque"

  root :to => "application#landing_page"
  get '/dashboard', to: 'application#index'

  match 'auth/twitter/callback', to: 'sessions#create'
  match 'auth/runkeeper/callback', to: 'registrations#create'
  match 'auth/mapmyfitness/callback', to: 'registrations#create'

  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'auth/failure', to: redirect('/')
  match 'post_to_twitter', to: "application#post_to_twitter"
  get '/user', to: 'application#request_user'
  # match 'create_run', to: "runs#create_run", as: "create_run"
  resources :runs

  resources :routes, only: [:create, :show]

  get '/profile', to: 'users#show', as: 'profile'

end
