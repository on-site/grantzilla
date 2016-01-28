class BudgetsController < ApplicationController
  def index
    @grant = Grant.find params[:grant_id]
    @grant.create_last_month_budget if @grant.last_month_budget.nil?
    @grant.create_current_month_budget if @grant.current_month_budget.nil?
    @grant.create_next_month_budget if @grant.next_month_budget.nil?
  end
end
