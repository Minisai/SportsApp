require 'spec_helper'

describe RewardImage do
  it { should validate_presence_of(:image) }

  it { should belong_to(:creator) }
  it { should have_many(:rewards) }
end
