$(document).on "change", "input.money", ->
  element = $(@)
  value = accounting.unformat element.val()
  element.val(accounting.formatNumber value, 2, "")
  element.trigger("format.money")
