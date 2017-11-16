module Api::V1
  class Api::V1::FriendsController < Api::V1::ApiController
    before_action :set_friend_service, only: [:connect, :common]

    api :POST, '/friends/connect', 'Connecting two emails'
    param :friends, Array, of: String, required: true
    def connect
      response = @connection.validate_connection
      if response[:success]
        connected = @connection.connecting_users
        if connected[:success]
          raw_response({success: true})
        else
          error_response({success: false, message: connected[:message]}, :bad_request)
        end
      else
        error_response({success: false, message: response[:message]}, :bad_request)
      end
    end

    api :POST, '/friends/list', 'Get friend list from an email'
    param :email, String, required: true
    def list
      user = User.find_by_email(email_params[:email])
      if user
        raw_response({success: true, friends: user.friend_list, count: user.friends.count})
      else
        error_response({success: false, message: "Couldn't find user with email #{email_params[:email]}"}, :not_found)
      end
    end

    api :POST, '/friends/common', 'Find common friends between two emails'
    param :friends, Array, of: String, required: true
    def common
      response = @connection.validate_connection
      if response[:success]
        commons = Friend.common(@connection.users.first, @connection.users.last)
        raw_response({success: true, friends: commons, count: commons.count})
      else
        error_response({success: false, message: response[:message]}, :bad_request)
      end
    end

    private

    def friends_params
      params.permit(friends: [])
    end

    def email_params
      params.permit(:email)
    end

    def set_friend_service
      @connection = FriendshipService.new(friends_params[:friends])
    end
  end
end