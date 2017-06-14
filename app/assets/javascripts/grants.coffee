# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "change", ".agency-filter, .worker-filter", ->
  $(@).parents("form").submit()

$(document).on "turbolinks:load", ->
  $.guard("#grant_grant_amount_requested").using("moneyUS", { max: 2500.00 })
