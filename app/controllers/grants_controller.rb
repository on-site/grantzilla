class GrantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grant, only: [:show, :edit, :update, :update_controls, :destroy]

  def index
    @grants = Grant.order(application_date: :desc)
  end

  def show
  end

  def new
    @grant = Grant.new
    @grant.people.build
  end

  def edit
  end

  def create
    @grant = Grant.new(grant_params)
    @grant.application_date = Time.zone.today

    if @grant.save
      redirect_to @grant
    else
      render :new
    end
  end

  def update
    update_params = params[:grant_controls] && "TODO: IS_ADMIN?" ? grant_admin_params : grant_params
    if @grant.update(update_params)
      redirect_to @grant
    else
      render :edit
    end
  end

  def update_controls
    # TODO: Check access
    if @grant.update(grant_admin_params)
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
    params.require(:grant).permit(:grant_amount, :check_number, :payee)
  end
end
