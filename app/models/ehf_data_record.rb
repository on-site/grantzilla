# This class provides read-only access to an EHF data record.  The data records native format
# is a CSV row. The EHF data record is an array matching each column in the CVS file. The CVS
# headings is an array matching the heading of each column.  The CVS headings are used as keys
# to lookup the position in the EHF data record of the associated data.
# rubocop:disable ClassLength
class EhfDataRecord
  def initialize(csv_headings, csv_row, lookup_cache)
    @csv_heading_hash = convert_headers_to_hash csv_headings
    @csv_row = csv_row
    @lookup_cache = lookup_cache
    validate
  end

  # These fields are required for importing the record.
  def validate
    raise StandardError, "Record skipped because no EHF Number found." if value("EHF.").blank?
    raise StandardError, "Record skipped because no Client First Name found." if value("Client 1 FN").blank?
    raise StandardError, "Record skipped because no Client Last Name found." if value("Client 1 LN").blank?
  end

  def grant_number
    value("EHF.")
  end

  def application_date
    application_date = value("Date")
    valid_date_string?(application_date) ? Date.strptime(application_date, '%m/%d/%Y') : nil
  end

  def agency_name
    return "#{value('Agency')} (#{agency_city})" if agency_city.present?
    value("Agency")
  end

  def agent_first_name
    value("Ag Con FN")
  end

  def agent_last_name
    value("Ag Con LN")
  end

  def agency_address
    value("Ag Address")
  end

  def agent_full_name
    "#{agent_first_name} #{agent_last_name}"
  end

  def agent_fake_password
    "password_#{agent_full_name}_#{grant_number}"
  end

  def agent_fake_email
    user_name = agent_full_name.strip.downcase.gsub(/[^a-z ]/, '').tr(' ', '_').downcase
    "imported_user_#{user_name}_#{grant_number}@no_email.com"
  end

  def agency_city
    extract_city value("Ag City, State")
  end

  def agency_state
    extract_state value("Ag City, State")
  end

  def agency_zip_code
    value("Ag Zip")
  end

  def agency_county
    value("County")
  end

  def agency_phone
    sanitize_phone_number value("Ag Phone")
  end

  def agency_ext
    value("Ext")
  end

  def agent_cell
    sanitize_phone_number value("Cell")
  end

  def agency_fax
    sanitize_phone_number value("Ag Fax")
  end

  def agency_email
    value("Email")
  end

  def client1_first_name
    value("Client 1 FN")
  end

  def client1_last_name
    value("Client 1 LN")
  end

  def client1_dob
    dob = value("Client 1 DOB")
    valid_date_string?(dob) ? dob : nil
  end

  def client1_email
    value("Client 1 Email")
  end

  def client1_income_type_id
    client1_income_type_keys.each_index do |i|
      if string_to_boolean value(client1_income_type_keys[i])
        return lookup_client_income_source_id i
      end
    end
    nil
  end

  def client2_first_name
    value("Client 2 FN")
  end

  def client2_last_name
    value("Client 2 LN")
  end

  def client2_dob
    dob = value("Client 2 DOB")
    valid_date_string?(dob) ? dob : nil
  end

  def client2_email
    value("Client 2 Email Address")
  end

  def client2_income_type_id
    client2_income_type_keys.each_index do |i|
      if string_to_boolean value(client2_income_type_keys[i])
        return lookup_client_income_type_id i
      end
    end
    nil
  end

  def property_address
    value("Prop Add")
  end

  def property_city
    extract_city value("Prop City & State")
  end

  def property_state
    extract_state value("Prop City & State")
  end

  def property_zip_code
    value("Prop Zip")
  end

  def residence_type_id
    residence_type_keys.each_index do |i|
      if string_to_boolean value(residence_type_keys[i])
        return lookup_residence_type_id i
      end
    end
    nil
  end

  def adults
    value("Adults").to_i
  end

  def dependents
    value("Dependents").to_i
  end

  def full_amount
    currency_to_double value("Full Amt")
  end

  def check_amount
    currency_to_double value("Check Amt")
  end

  def check_number
    value("Check .")
  end

  def payee
    value("Payee")
  end

  def payee_prefix
    value("P Prefix")
  end

  def payee_first_name
    value("Payee FN")
  end

  def payee_last_name
    value("Payee LN")
  end

  def payee_address
    value("Payee Address")
  end

  def payee_city
    extract_city value("Payee City, State")
  end

  def payee_state
    extract_state value("Payee City, State")
  end

  def payee_zip_code
    value("Payee Zip")
  end

  def payee_phone
    sanitize_phone_number value("P Phone")
  end

  def payee_ext
    value("P Ext")
  end

  def payee_fax
    sanitize_phone_number value("P Fax")
  end

  def coverage_type
    coverage_type_keys.each_index do |i|
      if string_to_boolean value(coverage_type_keys[i])
        return lookup_coverage_type i
      end
    end
    nil
  end

  def subsidy_type_id
    subsidy_type_keys.each_index do |i|
      if string_to_boolean value(subsidy_type_keys[i])
        return lookup_subsidy_type_id i
      end
    end
    nil
  end

  def use
    value("Use")
  end

  def use_for_illness
    value("Use: Illness")
  end

  def reason
    value("Criterion")
  end

  def reason_type
    reason_type_keys.each_index do |i|
      if string_to_boolean value(reason_type_keys[i])
        return lookup_reason_type i
      end
    end
    nil
  end

  def vip
    string_to_boolean value("VIP")
  end

  def description
    value("Description")
  end

  def comments
    value("Comments")
  end

  def first_letter_date
    string_to_date value("1st Letter")
  end

  def second_letter_date
    string_to_date value("2nd Letter")
  end

  def response_date
    string_to_date value("Response")
  end

  def still_resident?
    string_to_boolean value("Still Resident")
  end

  def resident_duration
    value("How long?")
  end

  def permanent_housing?
    value("Perm housing?")
  end

  def eval_information
    value("Eval Info")
  end

  def approved_status_id
    grant_status = lookup_cache.grant_status "Approved"
    return grant_status.id if grant_status.present?
    nil
  end

  private

  attr_reader :csv_heading_hash, :csv_row, :lookup_cache

  def convert_headers_to_hash(header)
    header.map.with_index { |c, i| [c, i] }.to_h
  end

  def sanitize_phone_number(value)
    return nil if value.blank?
    value.gsub(/\D/, '')
  end

  def extract_state(value)
    return nil if value.blank?
    fields = value.split(",")
    fields[1]
  end

  def extract_city(value)
    return nil if value.blank?
    fields = value.split(",")
    fields[0]
  end

  def currency_to_double(value)
    return nil if value.blank?
    Float(value.delete("$").to_f).round(2)
  end

  def string_to_boolean(value)
    return nil if value.blank?
    value.casecmp('true') == 0 || value.casecmp('yes') == 0
  end

  # Quick and dirty check for the issues we found in the CSV file.
  def valid_date_string?(value)
    return false if value.blank?
    return false if value =~ /[A-Z a-z]/
    return verify_date_parts(value.split('/')) if value.include?('/')
    false
  end

  def verify_date_parts(parts)
    return false if parts.length != 3
    return false if date_part_not_number? parts
    return false if date_part_out_of_range? parts
    true
  end

  def date_part_not_number?(parts)
    !number?(parts[0]) || !number?(parts[1]) || !number?(parts[2])
  end

  def date_part_out_of_range?(parts)
    parts[0].to_i > 12 || parts[1].to_i > 31 || parts[2].to_i > 2016
  end

  def number?(value)
    Float(value)
    true
  rescue
    false
  end

  def reason_type_keys
    ["Criteria: Injury", "Criteria: Illness", "Criteria: Death in the family",
     "Criteria: Natural disaster", "Criteria: Currently homeless",
     "Criteria: Moving from unsuitable living conditions", "Criteria: Victim of crime",
     "Criteria: Temporary loss of employement", "Criteria: Rent increase unaffordable",
     "Criteria: No-fault notice to vacate", "Criteria: Unanticipated expenses",
     "Criteria: Moving from shelter", "Criteria: Delay/cancellation of assistance or benefits",
     "Criteria: Other"]
  end

  def reason_type_descriptions
    ["Injury", "Illness", "Death in the family", "Natural disaster", "Currently homeless",
     "Moving from unsuitable living conditions", "Victim of crime",
     "Temporary loss of employment", "Rent increase unaffordable", "No-fault notice to vacate",
     "Unanticipated expenses", "Moving from shelter", "Delay/cancellation of assistance or benefits",
     "Other"]
  end

  def lookup_reason_type(ordinal)
    lookup_cache.reason_type reason_type_descriptions[ordinal]
  end

  def subsidy_type_keys
    ["Housing 1000", "Section 8 voucher", "HUD-VASH"]
  end

  def lookup_subsidy_type_id(ordinal)
    subsidy_type = lookup_cache.subsidy_type subsidy_type_keys[ordinal]
    return subsidy_type.id if subsidy_type.present?
    nil
  end

  def coverage_type_keys
    ["Use of HIF Funds: Current month's rent",
     "Use of HIF Funds: Past due rent(not including current month)",
     "Use of HIF Funds: Security Deposit( prior to move-in)",
     "Use of HIF Funds: Security Deposit( past-due, after move-in)",
     "Use of HIF Funds: Utilities"]
  end

  def coverage_type_descriptions
    ["Current month's rent",
     "Past due rent (not including current month)",
     "Security Deposit (prior to move-in)",
     "Security Deposit (past-due, after move-in)",
     "Utilities"]
  end

  def lookup_coverage_type(ordinal)
    lookup_cache.coverage_type coverage_type_descriptions[ordinal]
  end

  def residence_type_keys
    ["Room", "Apartment", "Single family home", "Townhome"]
  end

  def residence_type_descriptions
    ["Room", "Apartment", "Single family home", "Town home"]
  end

  def lookup_residence_type_id(ordinal)
    residence_type = lookup_cache.residence_type residence_type_descriptions[ordinal]
    return residence_type.id if residence_type.present?
    nil
  end

  def client1_income_type_keys
    ["Client 1 :Source of Income: Employment",
     "Client 1 :Source of Income:SSI/SSDI",
     "Client 1: Source of Income: EDD",
     "Client 1 : Source of Income: None",
     "Client 1 : Source of Income: Permanently Disabled",
     "Client 1 : Source of Income: Temporarily Disabled"]
  end

  def client2_income_type_keys
    ["Client 2 :Source of Income: Employment",
     "Client 2:Source of Income:SSI/SSDI",
     "Client 2: Source of Income: EDD",
     "Client 2: Source of Income: None",
     "Client 2 : Source of Income: Permanently Disabled",
     "Client 2 : Source of Income: Temporarily Disabled"]
  end

  def income_type_descriptions
    ["Employment", "SSI/SSDI", "EDD", "None", "Permanently Disabled", "Temporarily Disabled"]
  end

  def lookup_income_type_id(ordinal)
    income_type = lookup_cache.income_type client_income_source_descriptions[ordinal]
    return income_type.id if income_type.present?
    nil
  end

  def value(name)
    ordinal = csv_heading_hash[name]
    return nil if ordinal.blank? || csv_row[ordinal].blank?
    csv_row[ordinal]
  end
end
