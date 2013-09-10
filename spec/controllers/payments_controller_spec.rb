require 'spec_helper'

describe PaymentsController do
  describe :paypal_checkout do
    context "when user is paid" do
      before do
        controller.stub(:current_user => create(:coach_user, :expired_at => 1.month.since))
        get :paypal_checkout
      end
      it "should redirect to root" do
        expect(response).to redirect_to(:root)
      end
    end
  end
end
