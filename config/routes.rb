Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", :as => :rails_health_check

  root "pages#home"
  get "about", to: "pages#about"

  resources :articles, only: %i[show index new create edit update destroy]

  get "signup", to: "users#new"
  resources :users, except: %i[new]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :categories, except: %i[destroy]
end
