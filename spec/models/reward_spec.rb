require 'spec_helper'

describe Reward do
  it { should validate_presence_of(:name) }

  it { should belong_to(:creator) }
end