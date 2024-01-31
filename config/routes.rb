Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    get '/discover', to: 'users#discover', on: :member# not sure if this is where I want to go with this route
    get '/movies', to: 'users#movies', on: :member
    resources :movies, only: [:show], controller: 'movies'# I might regret this later (maybe user_movies controller?)
  end
end
