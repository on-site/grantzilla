# frozen_string_literal: true
# This class populates the grant data model from an EHF data record.,
class PopulateGrant
  def self.populate(ehf_data_record, residence, user, payee)
    Rails.logger.info "populating grant for #{ehf_data_record.grant_number}"
    grant = create_grant ehf_data_record, residence, user
    if grant.present?
      add_coverage_types grant, ehf_data_record.coverage_types.compact
      add_reason_types grant, ehf_data_record.reason_types.compact
      add_payee grant, payee
    end
    grant
  end

  def self.add_coverage_types(grant, coverage_types)
    grant.coverage_types << coverage_types if coverage_types.present?
  end
  private_class_method :add_coverage_types

  def self.add_reason_types(grant, reason_types)
    grant.reason_types << reason_types if reason_types.present?
  end
  private_class_method :add_reason_types

  def self.add_payee(grant, payee)
    grant.payees << payee if payee.present?
  end
  private_class_method :add_payee

  def self.create_grant(ehf_data_record, residence, user)
    Grant.create!(id: ehf_data_record.grant_number.to_i,
                  application_date: ehf_data_record.application_date,
                  details: ehf_data_record.description,
                  subsidy_type_id: ehf_data_record.subsidy_type_id,
                  grant_amount: ehf_data_record.check_amount,
                  grant_rsgp: ehf_data_record.vip,
                  grant_status_id: ehf_data_record.approved_status_id,
                  residence_id: residence.id,
                  user_id: user.id)
  end
  private_class_method :create_grant
end
