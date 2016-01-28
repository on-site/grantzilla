class GrantsController < ApplicationController
  before_action :set_grant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

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
    if @grant.update(grant_params)
      redirect_to @grant
    else
      render :edit
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
end
