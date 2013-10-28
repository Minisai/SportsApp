require 'spec_helper'

describe PlanSession do
  it { should have_many(:days) }
  it { should have_many(:plan_items) }
end
