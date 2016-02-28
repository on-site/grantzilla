# This class populates the people data model from an EHF data record.
class PopulatePerson
  def self.populate(ehf_data_record, grant)
    Rails.logger.info "populating person for #{ehf_data_record.grant_number}: #{client1_full_name(ehf_data_record)}"
    person1 = create_person1 ehf_data_record, grant
    create_person2(ehf_data_record, grant) if person1.present? && ehf_data_record.adults > 1
    person1
  end

  def self.client1_full_name(ehf_data_record)
    "#{ehf_data_record.client1_first_name} #{ehf_data_record.client1_last_name}"
  end
  private_class_method :client1_full_name

  def self.create_person1(ehf_data_record, grant)
    person = get_person ehf_data_record.client1_first_name,
                        ehf_data_record.client1_last_name,
                        ehf_data_record.client1_dob
    return person if person.present?
    create_person ehf_data_record.client1_first_name,
                  ehf_data_record.client1_last_name,
                  ehf_data_record.client1_dob,
                  ehf_data_record.client1_email,
                  grant
  end
  private_class_method :create_person1

  def self.create_person2(ehf_data_record, grant)
    person = get_person ehf_data_record.client2_first_name,
                        ehf_data_record.client2_last_name,
                        ehf_data_record.client2_dob
    return person if person.present?
    create_person ehf_data_record.client2_first_name,
                  ehf_data_record.client2_last_name,
                  ehf_data_record.client2_dob,
                  ehf_data_record.client2_email,
                  grant
  end
  private_class_method :create_person2

  def self.get_person(first_name, last_name, dob)
    if dob.present?
      Person.find_by(first_name: first_name, last_name: last_name, birth_date: dob)
    else
      Person.find_by(first_name: first_name, last_name: last_name)
    end
  end
  private_class_method :get_person

  def self.create_person(first_name, last_name, dob, email, grant)
    Person.create!(first_name: first_name, last_name: last_name, email: email, birth_date: dob, grant_id: grant.id)
  end
  private_class_method :create_person
end
