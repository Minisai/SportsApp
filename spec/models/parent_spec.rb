require 'spec_helper'

describe Parent do
  it { should have_one(:user) }
  it { should have_many(:players) }
end
