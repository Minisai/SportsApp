require 'spec_helper'

describe Payment do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:pricing_plan) }

  it { should belong_to(:user) }
  it { should belong_to(:pricing_plan) }
end
