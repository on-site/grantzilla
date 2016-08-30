# frozen_string_literal: true
module GrantsHelper
  def case_workers
    if current_user.admin?
      User.all
    else
      User.case_workers_by_agency current_user.agency
    end
  end
end
