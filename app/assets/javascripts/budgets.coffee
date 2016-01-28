calculateTotals = (month) ->
  month = $(month)
  budgetType = month.data("budget-type")
  subtotal = 0
  month.parents("tbody").find(".#{budgetType}").each (index, item) ->
    subtotal += accounting.unformat($(item).val())
  month.parents("table").find("tfoot .subtotal-#{budgetType}").html(accounting.formatMoney(subtotal))
  income = accounting.unformat $("table.income .subtotal-#{budgetType}").html()
  expenses = accounting.unformat $("table.expenses .subtotal-#{budgetType}").html()
  $("table.expenses tfoot .total-#{budgetType}").html accounting.formatMoney(income - expenses)

$(document).on "format.money", "table.budgets input.money", ->
  month = $(@)
  if month.hasClass("last-month-budget")
    otherMonths = month.parents("tr").find(".current-month-budget, .next-month-budget")
    otherMonths.each (index, otherMonth) ->
      otherMonth = $(otherMonth)
      return if otherMonth.val() != ""
      otherMonth.val month.val()
      calculateTotals otherMonth
  calculateTotals month

$ ->
  $("table.budgets tbody tr:first-of-type input.money").each (index, item) ->
   calculateTotals item
