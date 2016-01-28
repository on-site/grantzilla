$(document).on "format.money", "table.budgets input.money", ->
  month = $(@)
  if month.hasClass("last-month-budget")
    otherMonths = month.parents("tr").find(".current-month-budget, .next-month-budget")
    otherMonths.each (index, otherMonth) ->
      otherMonth = $(otherMonth)
      return if otherMonth.val() != ""
      otherMonth.val month.val()
