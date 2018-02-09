# frozen_string_literal: true
# rubocop:disable Metrics/ClassLength
# This class manages the reading of the CSV file and population of the different models.
class DataImportManager
  require 'csv'

  def initialize(csv_file)
    ActiveRecord::Base.logger.level = 1
    @csv_file = csv_file
    @ehf_data_records_imported = 0
    @errors = []
  end

  def import_data
    lookup_cache = LookupCache.new
    csv_rows = CSV.read(csv_file)
    csv_headings = csv_rows.first
    csv_rows.shift # skip headings
    process_rows csv_headings, csv_rows, lookup_cache
    display_results csv_rows.length
    log_history csv_rows.length
    save_to_db
  end

  private

  attr_reader :csv_file, :ehf_data_records_imported, :errors

  def display_results(ehf_data_records_processed)
    Rails.logger.info "Errors Encountered:"
    errors.each { |e| Rails.logger.info e }
    Rails.logger.info "Records Processed: #{ehf_data_records_processed}"
    Rails.logger.info "Record Imported: #{ehf_data_records_imported}"
  end

  def log_history(ehf_data_records_processed)
    DataImportHistoryLogs.create!(ehf_records_processed: ehf_data_records_processed,
                                  ehf_records_imported: ehf_data_records_imported,
                                  error_encountered: (errors.empty? ? nil : errors))
    nil
  end

  def process_rows(csv_headings, csv_rows, lookup_cache)
    csv_rows.each_index do |i|
      begin
        ehf_data_record = EhfDataRecord.new csv_headings, csv_rows[i], lookup_cache
        import_ehf_data_record ehf_data_record
      rescue StandardError => e
        error = "Row #{i + 2}: #{e}" # +2 to account for heading and zero based
        errors << error
        Rails.logger.error "#{error}: #{e.backtrace.slice(0, 2)}"
      end
    end
  end

  # Consider this a new record is the EHF Number is not associated with an existing grant.
  def new_ehf_data_record?(ehf_data_record)
    grants = Grant.where(id: ehf_data_record.grant_number)
    grants.empty?
  end

  def increment_ehf_data_records_imported
    @ehf_data_records_imported += 1
  end

  def import_ehf_data_record(ehf_data_record)
    if new_ehf_data_record? ehf_data_record
      agency = import_agency ehf_data_record
      residence = import_residence ehf_data_record
      user = import_user ehf_data_record, agency
      payee = import_payee ehf_data_record
      grant = import_grant ehf_data_record, residence, user, payee
      import_person ehf_data_record, grant
      increment_ehf_data_records_imported
    end
  end

  def save_to_db
    duplicated = []
    added = []
    ehf_data_records = CSV.open(csv_file, headers: true).map(&:to_h)
    ehf_data_records.map do |ehf|
      grant_id = ehf["EHF."]
      added.include?(grant_id) ? duplicated << grant_id : added << grant_id
      ImportedEhfRecord.create!(grant_id: grant_id,
                                ehf_record: ehf)
    end
    output_results(ehf_data_records.size, added.size, duplicated)
  end

  def output_results(number_ehf_records, number_added, duplicated)
    Rails.logger.error "Total ehf records: #{number_ehf_records}"
    Rails.logger.error "Processed grants: #{number_added}"
    Rails.logger.error "Duplicated grants: #{duplicated}"
  end

  def import_agency(ehf_data_record)
    agency = PopulateAgency.populate ehf_data_record
    return agency if agency.present? && agency.id.present?
    raise StandardError, "Import agency failed for #{ehf_data_record.grant_number}."
  end

  def import_residence(ehf_data_record)
    residence = PopulateResidence.populate ehf_data_record
    return residence if residence.present?
    raise StandardError, "Import residence failed for #{ehf_data_record.grant_number}."
  end

  def import_user(ehf_data_record, agency)
    user = PopulateUser.populate ehf_data_record, agency
    return user if user.present?
    raise StandardError, "Import user failed for #{ehf_data_record.grant_number}."
  end

  def import_payee(ehf_data_record)
    payee = PopulatePayee.populate ehf_data_record
    return payee if payee.present?
    raise StandardError, "Import payee failed for #{ehf_data_record.grant_number}."
  end

  def import_grant(ehf_data_record, residence, user, payee)
    grant = PopulateGrant.populate ehf_data_record, residence, user, payee
    return grant if grant.present?
    raise StandardError, "Import grant failed for #{ehf_data_record.grant_number}."
  end

  def import_person(ehf_data_record, grant)
    person = PopulatePerson.populate ehf_data_record, grant
    return person if person.present?
    raise StandardError, "Import person failed for #{ehf_data_record.grant_number}."
  end
end
