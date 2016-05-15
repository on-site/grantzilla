class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_found_error
    render template: "errors/404", status: 404
  end

  def permission_error
    render template: "errors/403", status: 403
  end

  def requires_admin
    permission_error unless current_user.present? && current_user.admin?
  end
end
