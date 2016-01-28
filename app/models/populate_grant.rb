# This class populates the grant data model from an EHF data record.
class PopulateGrant
  def self.populate(ehf_data_record)
    Rails.logger.info "populating grant for #{ehf_data_record.ehf_number}"
  end
end
