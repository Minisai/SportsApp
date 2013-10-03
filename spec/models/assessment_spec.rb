require 'spec_helper'

describe Assessment do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it { should belong_to(:coach) }
  it { should have_many(:exercises) }
  it { should have_many(:drills).through(:exercises) }
end
