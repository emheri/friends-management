module Api::V1
  class Api::V1::SubscribesController < Api::V1::ApiController

    api :POST, '/subscribes', 'Subscribe to update from an email address'
    param :requestor, String, required: true, desc: "Requestor email"
    param :target, String, required: true, desc: "Target subscribe email"
    def create
      subscribe_service = SubscribeService.new(subscribes_params[:requestor], subscribes_params[:target])
      if subscribe_service.validate
        subscribe_service.subscribe
        raw_response({success: true})
      else
        error_response({success: false, message: subscribe_service.full_messages}, :not_found)
      end
    end

    private

    def subscribes_params
      params.permit(:requestor, :target)
    end
  end
end