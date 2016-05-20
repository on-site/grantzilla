class FormsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_grant
  before_action :initialize_grant

  include Wicked::Wizard
  steps :applicants, :overview, :properties, :payee, :employment, :uploads

  def show
    render_wizard
  end

  def update
    if @grant.persisted?
      @grant.update_attributes(form_params)
    else
      @grant = Grant.create(form_params)
    end
    redirect_to wizard_path(@next_step, grant_id: @grant.id)
  end

  private

  def find_grant
    @grant = Grant.find_if_visible(params[:grant_id], current_user)
  end

  def initialize_grant
    @grant.intialize_defaults(user_id: current_user.id)
    @comments = @grant.comments.joins(:user)
                      .select("users.first_name, users.last_name, comments.id, comments.body, comments.created_at")
    @upload = Upload.new(user_id: @grant.id, user_type: "Grant")
  end

  def form_params
    params.require(:grant).permit([:adjusted_rent, :details, :grant_amount_requested,
                                   :subsidy_type_id, :total_rent, :total_owed, reason_type_ids: []],
                                  people_attributes, payees_attributes, residence_attributes)
  end

  def people_attributes
    { people_attributes: [:id, :first_name, :last_name, :birth_date, :phone,
                          :email, :veteran, :student_status, :_destroy] }
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
