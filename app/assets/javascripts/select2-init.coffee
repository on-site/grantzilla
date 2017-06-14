$(document).on "turbolinks:load", ->
  $("select[multiple='multiple']").select2(theme: "bootstrap")
