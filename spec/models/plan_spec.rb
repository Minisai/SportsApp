require 'spec_helper'

describe Plan do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it { should belong_to(:coach) }
  it { should have_many(:plan_items) }
end
