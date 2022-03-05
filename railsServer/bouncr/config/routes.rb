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
  #given eventID, get all hosting users
  #given userID and userID, get all user's friends that are attending event
end
