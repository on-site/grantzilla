class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :requires_admin

  def index
    @users = User.list user_index_params
  end

  def update
    user = User.find params[:id]
    user.update_attributes user_update_params
    redirect_to root_path if user.save
  end

  def destroy
    user = User.find params[:id]
    redirect_to root_path if user.destroy
  end

  private

  def user_update_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :agency_id,
      :password,
      :password_confirmation,
      :current_password
    )
    params.require(:user).permit(:approved) if current_user.admin?
  end

  def user_index_params
    params.permit(:agency_id, :search, :page)
  end
end
