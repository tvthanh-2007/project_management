class ApplicationController < ActionController::API
  include RenderHelper

  # rails errors
  rescue_from StandardError, with: :render_internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  # custom errors
  rescue_from ApiErrors::ForbiddenError, with: :render_forbidden
  rescue_from ApiErrors::UnauthorizedError, with: :render_unauthorized


  def render_not_found(exception)
    render json: { error: exception.message || "Resource not found" }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    errors = exception.record.errors.map { |attr, msg| { attribute: attr.to_s, message: msg } }
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def render_bad_request(exception)
    render json: { error: exception.message || "Bad request" }, status: :bad_request
  end

  def render_unauthorized(exception)
    render json: { error: exception.message || "Unauthorized" }, status: :unauthorized
  end

  def render_forbidden(exception)
    render json: { error: exception.message || "Forbidden" }, status: :forbidden
  end

  def render_internal_server_error(exception)
    logger.error exception.message
    logger.error exception.backtrace.join("\n")

    render json: { error: "Internal server error" }, status: :internal_server_error
  end
end
