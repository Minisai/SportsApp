require 'spec_helper'

describe Plan do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it { should belong_to(:creator) }
  it { should have_many(:plan_items) }
  it { should have_many(:assignee_plans) }
  it { should have_many(:assignees) }
end
