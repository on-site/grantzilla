# This class populates the residence data model from an EHF data record.
class PopulateResidence
  def self.populate(ehf_data_record)
    Rails.logger.info "populating residence for #{ehf_data_record.grant_number}"
    residence = get_residence ehf_data_record
    residence = create_residence(ehf_data_record) unless residence.present?
    residence
  end

  def self.get_residence(ehf_data_record)
    Residence.find_by(address: ehf_data_record.property_address,
                      city: ehf_data_record.property_city,
                      state: ehf_data_record.property_state,
                      zip: ehf_data_record.property_zip_code)
  end
  private_class_method :get_residence

  def self.create_residence(ehf_data_record)
    Residence.create!(address: ehf_data_record.property_address,
                      city: ehf_data_record.property_city,
                      state: ehf_data_record.property_state,
                      zip: ehf_data_record.property_zip_code,
                      residence_type_id: ehf_data_record.residence_type_id)
  end
  private_class_method :create_residence
end
