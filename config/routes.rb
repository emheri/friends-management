Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :create do
        collection do
          post :notifications
        end
      end
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
