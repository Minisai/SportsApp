require 'spec_helper'

describe PlanSession do
  it { should have_many(:days) }
end
