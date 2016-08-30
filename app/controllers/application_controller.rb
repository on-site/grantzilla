# frozen_string_literal: true
class ApplicationController < ActionController::Base
  rescue_from Errors::NotAuthorizedError, with: :permission_error
  rescue_from Errors::NotFoundError, with: :not_found_error

  protect_from_forgery with: :exception

  def not_found_error
    render template: "errors/not_found", status: :not_found
  end

  def permission_error
    render template: "errors/unauthorized", status: :unauthorized
  end

  def requires_admin
    raise Errors::NotAuthorizedError unless current_user.present? && current_user.admin?
  end
end
