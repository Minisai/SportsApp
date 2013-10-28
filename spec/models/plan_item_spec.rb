require 'spec_helper'

describe PlanItem do
  it { should validate_presence_of(:item) }
  it { should belong_to(:item) }
end
