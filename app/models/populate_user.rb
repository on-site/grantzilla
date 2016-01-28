# This class populates the user data model from an EHF data record.
class PopulateUser
  def self.populate(ehf_data_record)
    Rails.logger.info "populating user for #{ehf_data_record.ehf_number}"
  end
end
