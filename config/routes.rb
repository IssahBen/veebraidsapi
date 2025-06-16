Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do 
      post "booking", to: "bookings#create"
      get  "booking", to:  "bookings#index"
      get  "reviews", to:  "reviews#index"
      post "reviews", to:  "reviews#create"
      post "login", to: "sessions#create"
      post "logout", to: "sessions#destroy"
      get "services", to: "services#index"
      get "bookings", to: "bookings#bookings"
      delete "logout", to: "sessions#destroy"
      put "booking/:id", to: "bookings#update"
      put "services/:id", to: "services#update"
      delete "services/:id", to: "services#destroy"
      post "services", to: "services#create"
      put "settings", to: "sessions#update"
      devise_scope :user do
       post 'password/forgot', to: 'passwords#create'
      put  'password/reset',  to: 'passwords#update'
      end
    end
  end
end
