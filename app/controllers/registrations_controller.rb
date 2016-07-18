# frozen_string_literal: true
class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name,
      :email, :agency_id,
      :password, :password_confirmation
    ).tap do |params|
      if params[:email].include?("hifinfo.org")
        params[:role] = 'admin'
        params[:agency_id] = Agency.find_hif.id
      end
    end
  end

  def account_update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :agency_id,
      :password,
      :password_confirmation,
      (:approved if current_user.admin?)
    )
  end
end
