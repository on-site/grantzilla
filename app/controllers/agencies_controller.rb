class AgenciesController < ApplicationController
  before_action :set_agency, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @agencies = Agency.order(:name)
  end

  def show
    @agency = Agency.find(params[:id])
  end

  def new
    @agency = Agency.new
  end

  def edit
  end

  def create
    @agency = Agency.new(agency_params)

    if @agency.save
      redirect_to @agency
    else
      render :new
    end
  end

  def update
    if @agency.update(agency_params)
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
    @agency = Agency.find(params[:id])
  end

  def agency_params
    params.require(:agency).permit(
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
