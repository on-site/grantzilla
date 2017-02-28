$(document).on "change", "label.btn-file input", ->
  $(@).closest("label").removeClass("btn-default").addClass("btn-success")
  $("#uploaded_filename").text("File selected: #{$(@).val().substring($(@).val().lastIndexOf("\\") + 1)}")

$(document).on "ready page:load turbolinks:load", ->
  $("#uploaded_filename").text("")
