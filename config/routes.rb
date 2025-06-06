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
    end
  end
end
