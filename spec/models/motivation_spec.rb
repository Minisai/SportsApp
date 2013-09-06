require 'spec_helper'

describe Motivation do
  subject { create(:motivation) }

  it { should validate_presence_of(:message) }
  it { should validate_uniqueness_of(:coach).scoped_to(:message) }

  it { should have_and_belong_to_many(:players) }
  it { should belong_to(:coach) }
end
