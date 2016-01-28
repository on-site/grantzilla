# This class populates the people data model from an EHF data record.
class PopulatePerson
  def self.populate(ehf_data_record)
    Rails.logger.info "populating person for #{ehf_data_record.ehf_number}"
  end
end
