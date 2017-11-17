module Api::V1
    class Api::V1::BlocksController < Api::V1::ApiController
  
      api :POST, '/blocks', 'Blocks updates from an email address'
      param :requestor, String, required: true
      param :target, String, required: true
      def create
        block_service = BlockService.new(blocks_params[:requestor], blocks_params[:target])
        if block_service.validate
          block_service.block
          raw_response({success: true})
        else
          error_response({success: false, message: block_service.full_messages}, :not_found)
        end
      end
  
      private
  
      def blocks_params
        params.permit(:requestor, :target)
      end
    end
  end