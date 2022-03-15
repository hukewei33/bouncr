Rails.application.routes.draw do
  apipie
  resources :organization_users
  resources :organization_events
  resources :organizations
  resources :friends
  resources :invites
  resources :events
  resources :hosts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :users
  post "/login", to: "users#login"
  #auto login gets all user details too
  get "/auto_login", to: "users#auto_login"
  #given userID, get all of user's hosting event, also indicating organization afflication 
  get "/events_for_host", to: "hosts#index_for_host"
  #given userID, get all of user's attending event
  get "/events_for_guest", to: "invites#index_for_guest"
  #given userID, get all of their friends relationships
  get "/user_friends", to: "friends#index_for_user"

  #given eventID, get all attending users
  get "/guests_for_event", to: 'invites#index_for_event'
  #given eventID, get all hosting users
  get "/hosts_for_event", to: 'hosts#index_for_event'
  
  #given search term, get all similar users
  get "/users_search", to: 'users#index_for_search'
  
end
