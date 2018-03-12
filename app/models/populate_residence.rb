# frozen_string_literal: true
# This class populates the residence data model from an EHF data record.
class PopulateResidence
  SAN_MATEO_COUNTY_ZIP_CODES = [
    94002, 94005, 94010, 94011, 94013, 94014, 94015, 94016, 94017, 94018,
    94019, 94020, 94021, 94025, 94026, 94027, 94028, 94030, 94037, 94038,
    94044, 94060, 94061, 94062, 94063, 94064, 94065, 94066, 94070, 94074,
    94080, 94083, 94096, 94098, 94128, 94401, 94402, 94403, 94404, 94497 ]
  SANTA_CLARA_COUNTY_ZIP_CODES = [
    94022, 94023, 94024, 94035, 94039, 94040, 94041, 94042, 94043, 94085,
    94086, 94087, 94088, 94089, 94301, 94302, 94303, 94304, 94305, 94306,
    94309, 95002, 95008, 95009, 95011, 95013, 95014, 95015, 95020, 95021,
    95026, 95030, 95031, 95032, 95035, 95036, 95037, 95038, 95042, 95044,
    95046, 95050, 95051, 95052, 95053, 95054, 95055, 95056, 95070, 95071,
    95101, 95103, 95106, 95108, 95109, 95110, 95111, 95112, 95113, 95115,
    95116, 95117, 95118, 95119, 95120, 95121, 95122, 95123, 95124, 95125,
    95126, 95127, 95128, 95129, 95130, 95131, 95132, 95133, 95134, 95135,
    95136, 95138, 95139, 95140, 95141, 95148, 95150, 95151, 95152, 95153,
    95154, 95155, 95156, 95157, 95158, 95159, 95160, 95161, 95164, 95170,
    95172, 95173, 95190, 95191, 95192, 95193, 95194, 95196 ]

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
                      county: county_from_zip(ehf_data_record.property_zip_code.to_i),
                      zip: ehf_data_record.property_zip_code,
                      residence_type_id: ehf_data_record.residence_type_id)
  end
  private_class_method :create_residence

  def self.county_from_zip(zip)
    if SAN_MATEO_COUNTY_ZIP_CODES.include?(zip)
      return "San Mateo"
    elsif SANTA_CLARA_COUNTY_ZIP_CODES.include?(zip)
      return "Santa Clara"
    end
  end
  private_class_method :county_from_zip
end
