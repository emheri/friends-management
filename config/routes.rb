Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :create
      namespace :friends do
        post :connect
        post :list
        post :common
      end
      resources :subscribes, only: :create
      resources :blocks, only: :create
    end
  end

  apipie
end
