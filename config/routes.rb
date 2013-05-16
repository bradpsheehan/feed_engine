FeedEngine::Application.routes.draw do
  root :to => "application#landing_page"

  get '/dashboard', to: 'application#index'

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match 'auth/failure', to: redirect('/')
  match 'post_to_twitter', to: "application#post_to_twitter"

  get '/user', to: 'application#request_user'

end
