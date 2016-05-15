class BudgetsController < ApplicationController
  before_filter :set_grant

  def index
    initialize_budgets_if_needed
    @comments = @grant.comments.joins(:user)
                      .select("users.first_name, users.last_name, comments.id, comments.body, comments.created_at")
  end

  def bulk_update
    copy_descriptions
    @grant = Grant.find params[:grant_id]
    if update_budgets
      flash[:notice] = "Budget updated successfully."
      redirect_to grant_path(@grant)
    else
      render :index
    end
  end

  private

  def update_budgets
    @grant.last_month_budget.update(budget_params(:last_month_budget)) &&
      @grant.current_month_budget.update(budget_params(:current_month_budget)) &&
      @grant.next_month_budget.update(budget_params(:next_month_budget))
  end

  def budget_params(type)
    budget_attributes = Budget.attribute_names.map(&:to_sym)
    budget_attributes.delete(:created_at)
    budget_attributes.delete(:updated_at)
    strip_symbols_from_money_params(budget_attributes)

    params[:grant].require(type).permit(budget_attributes)
  end

  def copy_descriptions
    copy_description(:installment_payments_description)
    copy_description(:miscellaneous_expenses_description)
  end

  def copy_description(field)
    value = params[:grant][:last_month_budget][field]
    params[:grant][:current_month_budget][field] = value
    params[:grant][:next_month_budget][field] = value
  end

  def initialize_budgets_if_needed
    @grant.create_last_month_budget if @grant.last_month_budget.nil?
    @grant.create_current_month_budget if @grant.current_month_budget.nil?
    @grant.create_next_month_budget if @grant.next_month_budget.nil?
    @grant.save if @grant.changed?
  end

  def set_grant
    @grant = Grant.visible_for_user(current_user).where(id: params[:grant_id]).first
    not_found_error if @grant.nil?
  end

  def strip_symbols_from_money_params(attributes)
    [:last_month_budget, :current_month_budget, :next_month_budget].each do |set|
      attributes.each do |attr|
        value = params[:grant][set][attr]
        next unless value.present?
        params[:grant][set][attr] = value.gsub(/[\$,\,]/, "")
      end
    end
  end
end
