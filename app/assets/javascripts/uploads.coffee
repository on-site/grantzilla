$(document).on "change", "label.btn-file input", ->
  $(@).closest("label").removeClass("btn-default").addClass("btn-success").text("File selected: #{$(@).val().substring($(@).val().lastIndexOf("\\") + 1)}")
