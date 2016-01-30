# This class populates the grant data model from an EHF data record.,
class PopulateGrant
  def self.populate(ehf_data_record, residence, user, payee)
    Rails.logger.info "populating grant for #{ehf_data_record.ehf_number}"
    grant = create_grant ehf_data_record, residence, user
    if grant.present?
      add_coverage_type grant, ehf_data_record.coverage_type
      add_reason_type grant, ehf_data_record.reason_type
      add_payee grant, payee
    end
    grant
  end

  def self.add_coverage_type(grant, coverage_type)
    grant.coverage_types << coverage_type if coverage_type.present?
  end
  private_class_method :add_coverage_type

  def self.add_reason_type(grant, reason_type)
    grant.reason_types << reason_type if reason_type.present?
  end
  private_class_method :add_reason_type

  def self.add_payee(grant, payee)
    grant.payees << payee if payee.present?
  end
  private_class_method :add_payee

  def self.create_grant(ehf_data_record, residence, user)
    Grant.create!(application_date: ehf_data_record.application_date,
                  details: ehf_data_record.description,
                  ehf_number: ehf_data_record.ehf_number,
                  subsidy_type_id: ehf_data_record.subsidy_type_id,
                  grant_amount: ehf_data_record.full_amount,
                  grant_status_id: ehf_data_record.approved_status_id,
                  residence_id: residence.id,
                  user_id: user.id)
  end
  private_class_method :create_grant
end
