Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      post "booking", to: "bookings#create"
      get  "booking", to:  "bookings#index"
      get  "reviews", to:  "reviews#index"
      post "reviews", to:  "reviews#create"
    end
  end
end
