# This class populates the payee data model from an EHF data record.
class PopulatePayee
  def self.populate(ehf_data_record)
    Rails.logger.info "populating payee for #{ehf_data_record.grant_number}: #{payee_full_name(ehf_data_record)}"
    payee = get_payee ehf_data_record
    payee = create_payee(ehf_data_record) unless payee.present?
    payee
  end

  def self.payee_full_name(ehf_data_record)
    "#{ehf_data_record.payee_first_name} #{ehf_data_record.payee_last_name}"
  end
  private_class_method :payee_full_name

  def self.get_payee(ehf_data_record)
    Payee.find_by(name: ehf_data_record.payee,
                  attention: payee_full_name(ehf_data_record),
                  street_address: ehf_data_record.payee_address,
                  city: ehf_data_record.payee_city,
                  state: ehf_data_record.payee_state,
                  zip: ehf_data_record.payee_zip_code,
                  phone: ehf_data_record.payee_phone,
                  check_amount: ehf_data_record.check_amount,
                  check_number: ehf_data_record.check_number)
  end
  private_class_method :get_payee

  def self.create_payee(ehf_data_record)
    Payee.create!(name: ehf_data_record.payee,
                  attention: payee_full_name(ehf_data_record),
                  street_address: ehf_data_record.payee_address,
                  city: ehf_data_record.payee_city,
                  state: ehf_data_record.payee_state,
                  zip: ehf_data_record.payee_zip_code,
                  phone: ehf_data_record.payee_phone,
                  check_amount: ehf_data_record.check_amount,
                  check_number: ehf_data_record.check_number)
  end
  private_class_method :create_payee
end
