require 'spec_helper'

describe Team do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:coach) }
  it { should validate_uniqueness_of(:name) }

  it { should belong_to(:coach) }
  it { should have_and_belong_to_many(:players) }
end
