# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  # include ActionController::RequestForgeryProtection
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, unless: -> { request.format.json? }

  before_action :authenticate_user

  respond_to :json

  private

  def authenticate_user
    head :unauthorized if request.headers['Authorization'].blank?

    authenticate_or_request_with_http_token do |token|
      jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

      @current_user_id = jwt_payload['id']
    end
  rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    head :unauthorized
  end

  def authenticate_user!(_options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
