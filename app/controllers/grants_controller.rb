class GrantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grant, only: [:show, :edit, :update, :update_controls, :add_comment, :destroy]
  before_action :set_controls_info, only: [:show, :edit]

  def index
    @grants = Grant.list(current_user, grant_index_params)
  end

  def show
  end

  def new
    redirect_to grant_forms_path(0, :applicants)
  end

  def edit
    redirect_to grant_forms_path(@grant, :applicants)
  end

  def create
    @grant = Grant.new(grant_params.merge(user_id: current_user.id))
    if @grant.save
      redirect_to @grant
    else
      render :new
    end
  end

  def update
    if @grant.update(grant_params.merge(user_id: current_user.id))
      redirect_to @grant
    else
      render :edit
    end
  end

  # rubocop:disable Metrics/AbcSize
  def update_controls
    raise unless current_user.admin?
    if @grant.update(grant_admin_params)
      payee = @grant.payees.last || Payee.new(grant_id: @grant.id)
      payee.update(grant_payee_params)
      render json: @grant
    else
      render json: { errors: @grant.errors.full_messages }
    end
  end

  def add_comment
    new_comment = @grant.comments.new(body: params[:body], user_id: current_user.id)
    if new_comment.save
      response = new_comment.attributes.merge(first_name: current_user.first_name, last_name: current_user.last_name)
      render json: response
    else
      render json: { errors: @grant.errors.full_messages }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    @grant.destroy
    redirect_to grants_url
  end

  private

  def set_grant
    @grant = Grant.visible_for_user(current_user).where(id: params[:id]).first
    not_found_error if @grant.nil?
  end

  def set_controls_info
    @grant_payee = @grant.payees.last || {}
    @comments = @grant.comments.joins(:user)
                      .select("users.first_name, users.last_name, comments.id, comments.body, comments.created_at")
  end

  def grant_params
    params.require(:grant).permit(:residence, people_attributes, residence_attributes)
  end

  def people_attributes
    { people_attributes: [:id, :first_name, :last_name, :birth_date, :email] }
  end

  def residence_attributes
    { residence_attributes: [:id, :residence_type_id, :address, :unit_number, :city, :state, :zip] }
  end

  def grant_admin_params
    params.require(:grant).permit(:grant_status_id, :grant_amount)
  end

  def grant_payee_params
    params.require(:payee).permit(:name, :check_number)
  end

  def grant_index_params
    params.permit(:agency_id, :search, :status, :user_id, :page)
  end
end
