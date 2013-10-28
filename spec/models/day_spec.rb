require 'spec_helper'

describe Day do
  it { should validate_presence_of(:plan_session) }

  it { should belong_to(:plan_session) }
  it { should have_many(:exercises) }
end
