module Api::V1
  class Api::V1::UsersController < Api::V1::ApiController

    api :POST, '/users', 'Register new user'
    param :email, String, required: true
    def create
      user = User.create!(user_params)
      raw_response({message: 'User successfully registered'}, :created)
    end

    api :POST, '/users/notifications', 'Send notifications to followers'
    param :sender, String, required: true
    param :text, String, required: true
    def notifications
      sender = User.find_by_email(notification_params[:sender])
      if sender
        raw_response({success: true, recipients: sender.send_feeder(notification_params[:text])})
      else
        error_response({success: false, message: "Couldn't find user with email #{notification_params[:sender]}"}, :not_found)
      end
    end

    private

    def user_params
      params.permit(:email)
    end

    def notification_params
      params.permit(:sender, :text)
    end
  end
end