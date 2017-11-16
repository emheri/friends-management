module Api::V1
  class Api::V1::FriendsController < Api::V1::ApiController

    api :POST, '/friends/connect', 'Connecting two emails'
    param :friends, Array, of: String, required: true
    def connect
      connection = FriendshipService.new(friends_params[:friends])
      response = connection.validate_connection
      if response[:success]
        connected = connection.connecting_users
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

    private

    def friends_params
      params.permit(friends: [])
    end

    def email_params
      params.permit(:email)
    end
  end
end