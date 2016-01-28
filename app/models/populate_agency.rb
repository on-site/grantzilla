# This class populates the agency data model from an EHF data record.
class PopulateAgency
  def self.populate(ehf_data_record)
    Rails.logger.info "populating agency for #{ehf_data_record.ehf_number}: #{ehf_data_record.agency_name}"
    agency = get_agency ehf_data_record
    return agency.first unless agency.empty?
    create_agency ehf_data_record
  end

  def self.get_agency(ehf_data_record)
    Agency.where(name: ehf_data_record.agency_name)
  end
  private_class_method :get_agency

  def self.create_agency(ehf_data_record)
    Agency.create!(name: ehf_data_record.agency_name, phone: ehf_data_record.agency_phone,
                   fax: ehf_data_record.agency_fax, email: ehf_data_record.agency_email,
                   address: ehf_data_record.agency_address, city: ehf_data_record.agency_city,
                   state: ehf_data_record.agency_state, zip: ehf_data_record.agency_zip_code)
  end
  private_class_method :create_agency
end
