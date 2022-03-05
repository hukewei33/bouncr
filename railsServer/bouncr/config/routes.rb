Rails.application.routes.draw do
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
  get "/auto_login", to: "users#auto_login"
  #given userID, get all of user's hosting event, also indicating organization afflication 
  get "/events_for_host", to: "events#index_for_host"
  #given userID, get all of user's attending event
  get "/events_for_guest", to: "events#index_for_guest"
  #given eventID, get all attending users
  get "/users_for_invited", to: 'users#index_for_invited'
  #given eventID, get all hosting users
  get "/users_for_hosting", to: 'users#index_for_hosting'
  #given search term, get all similar users
  get "/users_search", to: 'users#index_for_search'
  #given userID and userID, get all user's friends that are attending event
  get "/users_friends", to: 'users#index_friends'
end
