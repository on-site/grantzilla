#QUALIFYING_CRITERIA = [
#  "Injury/illness/death in family",
#  "Moving from temporary/unsuitable living conditions",
#  "Delay/cancellation/change in subsidy, assistance, or benefits"
#]
#
#QUALIFYING_CRITERIA.each do |criteria|
#  ReasonType.create(description: criteria)
#end

agency = Agency.create!({name: "HIF"})

admin_user = User.new
admin_user.email = "admin@hifinfo.org"
admin_user.password = "Helping0thers!"
admin_user.role = "admin"
admin_user.approved = true
admin_user.agency = agency
admin_user.skip_confirmation!
admin_user.save!

hif_user = User.new
hif_user.email = "inas@hifinfo.org"
hif_user.password = "housing!"
hif_user.role = "case_worker"
hif_user.approved = true
hif_user.agency = agency
hif_user.skip_confirmation!
hif_user.save!
