class FormsController < ApplicationController
  before_action :get_grant

  include Wicked::Wizard
  steps :applicants, :criteria, :ask, :properties, :payee, :employment

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

  def get_grant
    @grant = Grant.find(params[:grant_id])
  end

  def form_params
    params.require(:grant).permit(people_attributes)
  end

  def people_attributes
    {
      people_attributes: [
        :id,
        :first_name,
        :last_name,
        :birth_date,
        :phone,
        :email,
        :veteran,
        :student,
        :full_time_student,
        :_destroy
      ]
    }
  end

  def finish_wizard_path
    grant_path(@grant)
  end
end

