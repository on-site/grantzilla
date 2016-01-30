# This class populates the user data model from an EHF data record.
class PopulateUser
  def self.populate(ehf_data_record, agency)
    Rails.logger.info "populating user for #{ehf_data_record.ehf_number}: #{ehf_data_record.agent_full_name}"
    user = get_user ehf_data_record, agency
    user = create_user(ehf_data_record, agency) unless user.present?
    user
  end

  def self.get_user(ehf_data_record, agency)
    User.find_by(first_name: ehf_data_record.agent_first_name,
                 last_name: ehf_data_record.agent_last_name,
                 agency_id: agency.id)
  end
  private_class_method :get_user

  # Not using create! because we need to skip conformation of user password.
  def self.create_user(ehf_data_record, agency)
    user = User.new
    user.first_name = ehf_data_record.agent_first_name
    user.last_name = ehf_data_record.agent_last_name
    user.agency_id = agency.id
    user.password = ehf_data_record.agent_fake_password
    user.email = ehf_data_record.agent_fake_email
    user.skip_confirmation!
    user.save!
    user
  end
  private_class_method :create_user
end
