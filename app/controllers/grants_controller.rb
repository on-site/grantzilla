class GrantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grant, only: [:show, :edit, :update, :update_controls, :destroy]

  def index
    @grants = Grant.order(application_date: :desc)
  end

  def show
    @grant_statuses = GrantStatus.all
    @grant_payee = @grant.payees.last
  end

  def new
    @grant = Grant.new
    @grant.people.build
  end

  def edit
  end

  def create
    creates_grants = CreatesGrants.new(grant_params.merge(user_id: current_user.id))
    @grant = creates_grants.grant
    if creates_grants.save
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

  def update_controls
    # TODO: Check access
    if @grant.update(grant_admin_params)
      payee = @grant.payees.last || Payee.new(grant_id: @grant.id)
      payee.update(grant_payee_params)
      render json: @grant
    else
      render json: { errors: @grant.errors.full_messages }
    end
  end

  def destroy
    @grant.destroy
    redirect_to grants_url
  end

  private

  def set_grant
    @grant = Grant.find(params[:id])
  end

  def grant_params
    params.require(:grant).permit(people_attributes: [:id, :first_name, :last_name, :birth_date, :email])
  end

  def grant_admin_params
    params.require(:grant).permit(:grant_status_id, :grant_amount)
  end

  def grant_payee_params
    params.require(:payee).permit(:name, :check_number)
  end
end
