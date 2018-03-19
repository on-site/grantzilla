# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength
class GrantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grant, only: [:show, :edit, :update, :update_controls, :add_comment, :download_package, :destroy]
  before_action :set_controls_info, only: [:show, :edit]

  require 'rmagick'
  include Magick
  include PdfOptions

  def index
    @grants = Grant.list(current_user, grant_index_params)

    respond_to do |format|
      format.html
      format.csv { send_data ExportData.to_csv }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf_options(file_name: "grant_#{@grant.id}.#{@grant.updated_at.strftime('%Y-%m-%d')}",
                           debug: params[:debug].presence)
      end
    end
  end

  # rubocop:disable Metrics/MethodLength
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
    if @grant.update(grant_params)
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

  def download_package
    respond_to do |format|
      format.pdf do
        pdf_filename_hash = filename_hash
        render pdf_options(file_name: pdf_filename_hash[:application],
                           debug: params[:debug].presence).merge(
                             template: "grants/show",
                             save_to_file: pdf_filename_hash[:application],
                             disposition: 'attachment'
                           )

        DownloadPackage.new(@grant.id, pdf_filename_hash).create_in_pdf
        display_download_package(pdf_filename_hash[:package])
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    @grant.destroy
    redirect_to grants_url
  end

  private

  def set_grant
    @grant = Grant.find_if_visible(params[:id], current_user)
  end

  def set_controls_info
    @grant_payee = @grant.payees.last || {}
    @comments = @grant.comments.joins(:user)
                      .select("users.first_name, users.last_name, comments.id, comments.body, comments.created_at")
  end

  def grant_params
    params.require(:grant).permit(:residence, people_attributes, residence_attributes)
  end

  def grant_admin_params
    params.require(:grant).permit(:grant_status_id, :grant_amount, :grant_rsgp, :grant_survey)
  end

  def grant_index_params
    params.permit(:agency_id, :search, :status, :user_id, :page)
  end

  def grant_payee_params
    params.require(:payee).permit(:check_number)
  end

  def people_attributes
    { people_attributes: [:id, :first_name, :last_name, :birth_date, :email] }
  end

  def residence_attributes
    { residence_attributes: [:id, :residence_type_id, :address, :unit_number, :city, :county, :state, :zip] }
  end

  def filename_hash
    application_file = Tempfile.new("grant_#{@grant.id}.application.pdf")
    comments_file = Tempfile.new("grant_#{@grant.id}.comments.pdf")
    package_file = Tempfile.new("grant_#{@grant.id}.#{@grant.updated_at.strftime('%Y-%m-%d')}.pdf")

    {
      application: application_file.path,
      comments: comments_file,
      package: package_file.path
    }
  end

  def display_download_package(pdf_filename)
    send_file(pdf_filename,
              filename: pdf_filename,
              disposition: 'inline',
              type: "application/pdf")
  end
end
