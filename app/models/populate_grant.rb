# This class populates the grant data model from an EHF data record.,
class PopulateGrant
  def self.populate(ehf_data_record)
    Rails.logger.info "populating grant for #{ehf_data_record.ehf_number}"
    create_grant ehf_data_record
  end

  def self.create_grant(ehf_data_record)
    Grant.create!(application_date: ehf_data_record.application_date,
                  details: ehf_data_record.description,
                  ehf_number: ehf_data_record.ehf_number,
                  subsidy_type_id: ehf_data_record.subsidy_type_id,
                  grant_amount: ehf_data_record.full_amount,
                  grant_status_id: ehf_data_record.approved_status_id)
  end
  private_class_method :create_grant
end
