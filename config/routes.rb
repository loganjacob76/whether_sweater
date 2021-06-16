Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecasts#show'
      resources :backgrounds, only: :index
      resources :users, only: :create
      resources :sessions, only: :create
      post '/road_trip', to: 'road_trips#create'
      get '/unauthorized', to: 'road_trips#unauthorized'
    end
  end
end
