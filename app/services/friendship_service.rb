class FriendshipService

  attr_accessor :emails, :users, :invalid_emails

  def initialize(emails)
    @emails = emails
    @users = []
    @invalid_emails = []
  end

  def validate_connection
    success = true
    unless registered_emails?
      message = "The following emails #{@invalid_emails} has not been registered"
      success = false
    end
    unless valid_email_number?
      message = "number of emails should equal two"
      success = false
    end
    if same_email?
      message = "Can't create connection with same email"
      success = false
    end

    return {success: success, message: message}
  end

  def connecting_users
    connected = Friend.find_connection(@users[0].id, @users[1].id)
    if connected.blank?
      first = Friend.create({user_id: @users[0].id, friend_id: @users[1].id})
      second = Friend.create({user_id: @users[1].id, friend_id: @users[0].id})
      return {success: true}
    else
      return {success: false, message: "emails already connected"}
    end
  end

  private

  def valid_email_number?
    return @emails.count == 2 ? true : false
  end

  def registered_emails?
    @emails.each do |email|
      user = User.find_by_email(email)
      if user
        @users << user
      else
        @invalid_emails << email
      end
    end

    return @users.count == 2 ? true : false
  end

  def same_email?
    return @emails[0] == @emails[1] ? true : false
  end

end