require 'spec_helper'

describe Exercise do
  it { should validate_presence_of(:drill) }
  it { should validate_presence_of(:suite) }
  it { should belong_to(:drill) }
  it { should belong_to(:suite) }
end
