require 'spec_helper'

describe Motivation do
  subject { create(:motivation) }

  it { should validate_presence_of(:message) }
  it { should validate_uniqueness_of(:coach_id).scoped_to(:message) }

  it { should have_many(:motivation_players) }
  it { should have_many(:players).through(:motivation_players) }
  it { should belong_to(:coach) }
end
