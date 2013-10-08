require 'spec_helper'

describe Admin do
  it { should have_many(:rewards) }
end
