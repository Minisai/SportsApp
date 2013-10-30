require 'spec_helper'

describe AssigneePlan do
  it { should validate_presence_of(:assignee) }
  it { should validate_presence_of(:plan) }

  it { should belong_to(:assignee) }
  it { should belong_to(:plan) }
end
