require 'spec_helper'

describe Coach do
  it { should have_one(:user) }
  it { should have_many(:teams) }
  it { should have_many(:motivations) }

  it { should have_and_belong_to_many(:players) }

  describe :generate_program_code do
    let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
    let!(:coach) { create(:coach_user).role }

    it "program_code should be present" do
      expect(coach.program_code).to be_present
    end

    it "should send email" do
      expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 1
    end
  end
end
