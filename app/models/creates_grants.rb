# Create a Grant, and do any required setup
class CreatesGrants
  attr_reader :grant

  def initialize(grants_params)
    @grant = Grant.new(grants_params)
  end

  def save
    @grant.status = GrantStatus.initial
    @grant.save
  end
end
