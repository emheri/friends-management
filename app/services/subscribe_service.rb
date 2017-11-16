class SubscribeService

  attr_accessor :requestor, :target, :error_messages
  
  def initialize(requestor, target)
    @requestor = User.find_by_email(requestor)
    @target = User.find_by_email(target)
    @error_messages = []
  end

  def subscribe
    Subscribe.create!({user_id: @target.id, subscriber_id: @requestor.id})
  end

  def validate
    if @requestor.blank?
      @error_messages << "requestor not found"
    end

    if @target.blank?
      @error_messages << "target not found"
    end

    if @error_messages.count == 0
      return true
    else
      return false
    end
  end

  def full_messages
    @error_messages.join(" and ")
  end

  private

end