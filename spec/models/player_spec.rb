require 'spec_helper'

describe Player do
  it { should validate_presence_of(:coach) }

  it { should have_one(:user) }
  it { should belong_to(:coach) }
  it { should belong_to(:parent) }
end
