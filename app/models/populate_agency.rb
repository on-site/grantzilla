# frozen_string_literal: true
# This class populates the agency data model from an EHF data record.
class PopulateAgency
  def self.populate(ehf_data_record)
    Rails.logger.info "populating agency for #{ehf_data_record.grant_number}: #{ehf_data_record.agency_name}"
    agency = get_agency ehf_data_record
    agency = create_agency(ehf_data_record) unless agency.present?
    agency
  end

  def self.get_agency(ehf_data_record)
    Agency.find_by(name: ehf_data_record.agency_name)
  end
  private_class_method :get_agency

  def self.create_agency(ehf_data_record)
    Agency.create!(name: ehf_data_record.agency_name,
                   phone: ehf_data_record.agency_phone,
                   fax: ehf_data_record.agency_fax,
                   email: ehf_data_record.agency_email,
                   address: ehf_data_record.agency_address,
                   city: ehf_data_record.agency_city,
                   state: ehf_data_record.agency_state,
                   zip: ehf_data_record.agency_zip_code)
  end
  private_class_method :create_agency
end
