# This class populates the agency data model from an EHF data record.
class PopulateAgency
  def self.populate(ehf_data_record)
    Rails.logger.info "populating agency for #{ehf_data_record.ehf_number}: #{ehf_data_record.agency_name}"
  end
end
