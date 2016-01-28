class AgenciesController < ApplicationController
  before_action :set_agency, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @agencies = Agency.order(:name)
  end

  def show
  end

  def new
    @agency = Agency.new
  end

  def edit
  end

  def create
    @agency = Grant.new(agency_params.merge(user_id: current_user.id))
    @agency.application_date = Time.zone.today

    if @agency.save
      redirect_to @agency
    else
      render :new
    end
  end

  def update
    if @agency.update(agency_params.merge(user_id: current_user.id))
      redirect_to @agency
    else
      render :edit
    end
  end

  def destroy
    @agency.destroy
    redirect_to agencies_url
  end

  private

  def set_agency
    @agency = Grant.find(params[:id])
  end

  def agency_params
    params.permit(:agency).permit(
     :name,
     :phone,
     :fax,
     :email,
     :address,
     :city,
     :state,
     :zip,
    )
  end
end
