$(document).on "change", "input.money", ->
  element = $(@)
  value = accounting.unformat element.val()
  element.val(accounting.formatMoney value)
  element.trigger("format.money")
