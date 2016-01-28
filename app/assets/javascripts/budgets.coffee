$(document).on "format.money", "input.last_month_budget.money", ->
  last_month = $(@)
  other_months = last_month.parents("tr").find(".current_month_budget, .next_month_budget")
  other_months.each (index, month) ->
    return if $(month).val() != ""
    $(month).val last_month.val()
