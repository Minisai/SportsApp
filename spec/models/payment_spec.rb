require 'spec_helper'

describe Payment do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:pricing_plan) }
  it { should validate_presence_of(:paypal_customer_token) }

  it { should belong_to(:user) }
  it { should belong_to(:pricing_plan) }

  describe :update_user_info do
    context "when payment is completed" do
      let(:completed_payment) {create(:payment, :completed => true)}
      it "should assign user's expired_at attribute" do
        expect(completed_payment.user.expired_at).to eq Date.today + completed_payment.pricing_plan.duration.months
      end
    end
    context "when payment is not completed" do
      let(:payment) {create(:payment, :completed => false)}

      it "should not assign user's expired_at attribute" do
        expect(payment.user.expired_at).to be_blank
      end
    end
  end
end
