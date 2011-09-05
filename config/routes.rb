Tumaini::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  resources :sessions, :only => [:new, :create, :destroy]
  resources :users

  root :to => 'sessions#new'
end
