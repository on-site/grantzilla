# frozen_string_literal: true
class ExportData
  require 'csv'

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << Grant.column_names + add_person_type_names + add_grant_reason_name +
             add_grant_fund_usage_name +
             add_column_names_by_index(Person.column_names, 1) +
             add_column_names_by_index(Income.column_names, 1) +
             add_column_names_by_index(Person.column_names, 2) +
             add_column_names_by_index(Income.column_names, 2) +
             Residence.column_names + Payee.column_names
      Grant.all.find_each do |grant|
        next if grant.people.blank?
        grant_people_order_by_id = grant.people.order(:id)
        row = grant.attributes.values
        row += export_csv_person_type_count(grant.people)
        row += export_csv_grant_reasons(grant.reason_types)
        row += export_csv_grant_fund_usage(grant.coverage_types)
        row += export_csv_people_and_income(grant_people_order_by_id)
        row += export_csv_residences(grant.residence)
        row += export_csv_payees(grant.payees)
        csv << row
      end
    end
  end

  def self.add_person_type_names
    ["Total # of adults", "Total # of dependents"]
  end
  private_class_method :add_person_type_names

  def self.add_grant_fund_usage_name
    ["Use of funds"]
  end
  private_class_method :add_grant_fund_usage_name

  def self.add_grant_reason_name
    ["Reason"]
  end
  private_class_method :add_grant_reason_name

  def self.add_column_names_by_index(column_names, index)
    names = []
    column_names.each do |c|
      names << "#{c}#{index}"
    end
    names
  end
  private_class_method :add_column_names_by_index

  def self.blank_data_array(size)
    blank_data = []
    size.times do ||
      blank_data << ""
    end
    blank_data
  end
  private_class_method :blank_data_array

  def self.export_csv_grant_fund_usage(coverage_types)
    return blank_data_array(1) if coverage_types.blank?
    [coverage_types.join(" | ")]
  end
  private_class_method :export_csv_grant_fund_usage

  def self.export_csv_grant_reasons(reason_types)
    return blank_data_array(1) if reason_types.blank?
    [reason_types.join(" | ")]
  end
  private_class_method :export_csv_grant_reasons

  def self.export_csv_person_type_count(people)
    return blank_data_array(2) if people.blank?
    [people.select { |p| p.person_type == Person::ADULT }.count,
     people.select { |p| p.person_type == Person::DEPENDENT }.count]
  end
  private_class_method :export_csv_person_type_count

  def self.export_csv_people_and_income(people)
    # Handle max 2 people
    return blank_data_array((Person.column_names.size + Income.column_names.size) * 2) if people.blank?
    row = people[0].attributes.values
    row += person_income(people[0])

    if people.size > 1
      row += people[1].attributes.values
      row += person_income(people[1])
    else
      row += blank_data_array(Person.column_names.size)
      row += blank_data_array(Income.column_names.size)
    end
    row
  end
  private_class_method :export_csv_people_and_income

  def self.person_income(person)
    # Handle one income/employment for now
    # rubocop:disable Style/GuardClause
    if person.present? && person.incomes.present?
      return person.incomes[0].attributes.values
    else
      return blank_data_array(Income.column_names.size)
    end
  end
  private_class_method :person_income

  def self.export_csv_residences(residence)
    # Handle one residence for now
    return blank_data_array(Residence.column_names.size) if residence.blank?
    residence.attributes.values
  end
  private_class_method :export_csv_residences

  def self.export_csv_payees(payees)
    # Handle one payee for now
    return blank_data_array(Payee.column_names.size) if payees.blank?
    payees[0].attributes.values
  end
  private_class_method :export_csv_payees
end
