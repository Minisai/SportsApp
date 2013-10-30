require 'spec_helper'

describe Admin do
  it { should have_many(:rewards) }
  it { should have_many(:reward_images) }
  it { should have_many(:plans) }
end
