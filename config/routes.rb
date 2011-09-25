Tumaini::Application.routes.draw do
  match "remote_sessions/create(/:client_token)" => 'remote_sessions#create', :as => "remote_sessions"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  resources :client_apps, :except => :show
  resources :sessions, :only => [:new, :create, :destroy]
  resources :organizations, :except => :show do
    resources :users, :only => [:new, :create]
  end
  resources :users, :except => [:new, :create] do
    collection do
      get :authorize
    end
  end

  root :to => 'sessions#new'
end
