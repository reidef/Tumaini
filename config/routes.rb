Tumaini::Application.routes.draw do
  match "remote_sessions/create(/:client_token)" => 'remote_sessions#create'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users do
    collection do
      get :authorize
    end
  end

  root :to => 'sessions#new'
end
