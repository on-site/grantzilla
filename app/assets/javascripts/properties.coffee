$(document).on "change", "#copy-residence-address", ->
  index = $(@).data("index")
  address = $("#grant_residence_attributes_address").val()
  city = $("#grant_residence_attributes_city").val()
  state = $("#grant_residence_attributes_state").val()
  zip = $("#grant_residence_attributes_zip").val()
  if !$(@).is(":checked")
    address = city = state = zip = ""
  $("#grant_payees_attributes_#{index}_street_address").val(address)
  $("#grant_payees_attributes_#{index}_city").val(city)
  $("#grant_payees_attributes_#{index}_state").val(state)
  $("#grant_payees_attributes_#{index}_zip").val(zip)
