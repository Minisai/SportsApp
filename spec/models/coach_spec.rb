require 'spec_helper'

describe Coach do
  it { should have_one(:user) }
  it { should have_many(:players) }
end
