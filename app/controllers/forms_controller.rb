class FormsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_grant

  include Wicked::Wizard
  steps :applicants, :criteria, :ask, :properties, :payee, :employment, :uploads

  # applicants: Full applicants info (Applicants Basic Info + Additional person information)
  # criteria: Qualifying Criteria
  # ask: Grant request details
  # properties: Property + Previous residence Info
  # payee: Payee Info
  # employment: Applicants Employment/Unemployment

  def show
    render_wizard
  end

  def update
    @grant.assign_attributes(form_params)
    render_wizard @grant
  end

  private

  def find_grant
    @grant = Grant.find(params[:grant_id])
    @grant_statuses = GrantStatus.all
    @grant.payees.build if @grant.payees.empty?
    @grant.build_residence unless @grant.residence.present?
    @upload = Upload.new(user_id: @grant.id, user_type: "Grant")
    @comments = @grant.comments.joins(:user)
                      .select("users.first_name, users.last_name, comments.id, comments.body, comments.created_at")
  end

  def form_params
    params.require(:grant).permit([:details, reason_type_ids: []],
                                  people_attributes, payees_attributes, residence_attributes)
  end

  def people_attributes
    { people_attributes: [:id, :first_name, :last_name, :birth_date, :phone,
                          :email, :veteran, :student, :full_time_student, :_destroy] }
  end

  def payees_attributes
    { payees_attributes: [:id, :name, :attention, :street_address, :unit_number,
                          :city, :state, :zip, :email, :phone, :_destroy] }
  end

  def residence_attributes
    { residence_attributes: [:id, :residence_type_id, :address, :unit_number, :city,
                             :state, :zip, :_destroy] }
  end

  def finish_wizard_path
    grant_path(@grant)
  end
end
