require 'spec_helper'

describe PricingPlan do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:role_type) }
  it { should validate_presence_of(:cost) }
  it { should validate_presence_of(:duration) }
end
