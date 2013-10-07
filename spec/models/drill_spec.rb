require 'spec_helper'

describe Drill do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:exercises) }
end
