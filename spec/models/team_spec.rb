require 'spec_helper'

describe Team do
  it { should have_many(:players) }
  it { should belong_to(:coach) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:coach) }
  it { should validate_uniqueness_of(:name) }
end
