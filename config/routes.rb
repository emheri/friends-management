Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :create
      namespace :friends do
        post :connect
      end
    end
  end

  apipie
end
