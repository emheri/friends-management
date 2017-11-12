module Concerns::Response
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  end

  def raw_response(response, status = :ok)
    render json: response, status: status
  end

  def json_response(object, status = :ok, options = {})
    render json: serialized_response(object, options), status: status
  end

  def error_response(errors, status = :unauthorized)
    render json: JSONAPI::Serializer.serialize_errors(errors), status: status
  end
  
  def render_not_found_response(exception)
    error_response({ details: exception.message }, :not_found) #404 status
  end

  def render_unprocessable_entity_response(exception)
    error_response({ details: exception.record.errors },
      :unprocessable_entity) #422 status
  end
end