# This class stores the lookup values to avoid trips to the database.
class LookupCache
  def income_type_id(description)
    income_type_hash.get(description)
  end

  def residence_type_id(description)
    residence_type_hash[description]
  end

  def coverage_type_id(description)
    coverage_type_hash.get(description)
  end

  def subsidy_type_id(description)
    subsidy_type_hash.get(description)
  end

  def reason_type_id(description)
    reason_type_hash.get(description)
  end

  def grant_status_id(description)
    reason_type_hash.get(description)
  end

  private

  def income_type_hash
    @income_type_hash ||= IncomeType.all.map { |t| [t.description, t.id] }.to_h
  end

  def residence_type_hash
    @residence_type_hash ||= ResidenceType.all.map { |t| [t.description, t.id] }.to_h
  end

  def coverage_type_hash
    @coverage_type_hash ||= CoverageType.all.map { |t| [t.description, t.id] }.to_h
  end

  def subsidy_type_hash
    @subsidy_type_hash ||= SubsidyType.all.map { |t| [t.description, t.id] }.to_h
  end

  def reason_type_hash
    @reason_type_hash ||= ReasonType.all.map { |t| [t.description, t.id] }.to_h
  end

  def grant_status_hash
    @grant_status_hash ||= GrantStatus.all.map { |t| [t.description, t.id] }.to_h
  end
end
