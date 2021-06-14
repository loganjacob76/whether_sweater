Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecasts#show'
      get '/book-search', to: 'books#index'
    end
  end
end
