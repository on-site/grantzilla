class RegistrationsController < Devise::RegistrationsController
  private

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
      :current_password,
    )
    params.require(:user).permit(:approved) if current_user.admin?
  end
end
