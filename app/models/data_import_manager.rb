# This class manages the reading of the CSV file and population of the different models.
class DataImportManager
  require 'csv'

  def initialize(csv_file)
    @csv_file = csv_file
    @ehf_data_records_imported = 0
    @errors = []
  end

  def import_data
    csv_rows = CSV.read(csv_file)
    csv_headings = csv_rows.first
    csv_rows.shift # skip headings
    process_rows csv_headings, csv_rows
    log_history csv_rows.length
  end

  private

  attr_reader :csv_file, :ehf_data_records_imported, :errors

  def log_history(ehf_data_records_processed)
    DataImportHistoryLogs.create!(ehf_records_processed: ehf_data_records_processed,
                                  ehf_records_imported: ehf_data_records_imported,
                                  error_encountered: (errors.empty? ? nil : errors))
  end

  def process_rows(csv_headings, csv_rows)
    lookup_cache = LookupCache.new
    csv_rows.each_index do |i|
      ehf_data_record = EhfDataRecord.new csv_headings, csv_rows[i], lookup_cache
      import_ehf_data_record ehf_data_record, i
    end
  end

  # Consider this a new record is the EHF Number is not associated with an existing grant.
  def new_ehf_data_record?(ehf_data_record)
    ehf_data_record.ehf_number != 0
  end

  def increment_ehf_data_records_imported
    @ehf_data_records_imported += 1
  end

  def import_ehf_data_record(ehf_data_record, row_ordinal)
    ehf_data_record.validate
    if new_ehf_data_record? ehf_data_record
      agency = PopulateAgency.populate ehf_data_record
      PopulateUser.populate ehf_data_record
      PopulateGrant.populate ehf_data_record
      PopulatePerson.populate ehf_data_record
      increment_ehf_data_records_imported
    end
  rescue StandardError => e
    errors << "Row #{row_ordinal + 2}: #{e}" # +2 to account for heading and zero based
  end
end
