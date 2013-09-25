require 'spec_helper'

describe Invitation do
  it { should validate_presence_of(:player) }
  it { should validate_presence_of(:coach) }
  it { should validate_presence_of(:status) }
  it { should validate_uniqueness_of(:player_id).scoped_to(:coach_id) }

  context :send_invitation_email do
    let!(:coach) { create(:coach_user).role }
    let!(:player) { create(:player_user).role }
    it "should send email on successful create" do
      expect { create(:invitation, :coach => coach, :player => player) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
