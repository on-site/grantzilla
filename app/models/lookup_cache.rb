# This class stores the lookup values to avoid trips to the database.
class LookupCache
  def income_type(description)
    income_type_hash[description]
  end

  def residence_type(description)
    residence_type_hash[description]
  end

  def coverage_type(description)
    coverage_type_hash[description]
  end

  def subsidy_type(description)
    subsidy_type_hash[description]
  end

  def reason_type(description)
    reason_type_hash[description]
  end

  def grant_status(description)
    grant_status_hash[description]
  end

  private

  def income_type_hash
    @income_type_hash ||= IncomeType.all.map { |t| [t.description, t] }.to_h
  end

  def residence_type_hash
    @residence_type_hash ||= ResidenceType.all.map { |t| [t.description, t] }.to_h
  end

  def coverage_type_hash
    @coverage_type_hash ||= CoverageType.all.map { |t| [t.description, t] }.to_h
  end

  def subsidy_type_hash
    @subsidy_type_hash ||= SubsidyType.all.map { |t| [t.description, t] }.to_h
  end

  def reason_type_hash
    @reason_type_hash ||= ReasonType.all.map { |t| [t.description, t] }.to_h
  end

  def grant_status_hash
    @grant_status_hash ||= GrantStatus.all.map { |t| [t.description, t] }.to_h
  end
end
