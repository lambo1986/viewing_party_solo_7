Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    get '/discover', to: 'users#discover', on: :member# not sure if this is where I want to go with this route
    get '/movies', to: 'users#movies', on: :member
    resources :movies, only: [:show] do# I might regret this later (need user_movies controller?)
      resources :similar, only: [:index], controller: 'similar_movies'
      resource :viewing_party, only: [:new, :create]
      get '/viewing_party/:id', to: 'viewing_parties#show'
    end
  end
end
