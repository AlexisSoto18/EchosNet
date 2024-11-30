Rails.application.routes.draw do
  devise_for :users
  get "users/download_pdf", to: "users#download_pdf", as: "download_user_pdf"
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  # Define the routes for the tweeets resource
  resources :tweeets do
    collection do
      get :following
      get :followers
    end
    resources :retweets
  end
  # Rutas para seguir y dejar de seguir usuarios
  resources :users do
    member do
      post "follow", to: "followings#create"
      delete "unfollow", to: "followings#destroy"
      get "following", to: "users#following"
      get "followers", to: "users#followers"
    end
  end
  resources :followings, only: [ :create, :destroy ]
  # Ruta raiz
  root "tweeets#index"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
