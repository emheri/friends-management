module Api::V1
  class Api::V1::UsersController < Api::V1::ApiController

    api :POST, '/users', 'Register new user'
    param :email, String, required: true
    def create
      user = User.create!(user_params)
      raw_response({message: 'User successfully registered'}, :created)
    end

    private

    def user_params
      params.permit(:email)
    end
  end
end