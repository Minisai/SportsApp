require 'spec_helper'

describe Assessment do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).scoped_to(:coach_id) }

  it { should belong_to(:coach) }
  it { should have_many(:exercises) }
  it { should have_many(:drills).through(:exercises) }
  it { should have_many(:plan_items) }
end
