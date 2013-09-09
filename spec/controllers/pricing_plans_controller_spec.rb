require 'spec_helper'

describe PricingPlansController do
  describe "GET index" do
    let!(:pricing_plans_for_player) { create_list(:pricing_plan_for_player, 4) }
    let!(:pricing_plans_for_coach) { create_list(:pricing_plan_for_coach, 4) }
    let!(:pricing_plans_for_parent) { create_list(:pricing_plan_for_parent, 4) }
    let!(:all_pricing_plans) { pricing_plans_for_player + pricing_plans_for_coach + pricing_plans_for_parent }

    context "when coach user signed in" do
      before do
        controller.stub(:current_user => create(:coach_user))
        get :index
      end

      it "response should be ok" do
        expect(response).to be_ok
      end

      it "@pricing_plans should be pricing plans for coaches" do
        expect(assigns(:pricing_plans)).to match_array pricing_plans_for_coach
      end
    end

    context "when player user signed in" do
      before do
        controller.stub(:current_user => create(:player_user))
        get :index
      end

      it "response should be ok" do
        expect(response).to be_ok
      end

      it "@pricing_plans should be pricing plans for players" do
        expect(assigns(:pricing_plans)).to match_array pricing_plans_for_player
      end
    end

    context "when parent user signed in" do
      before do
        controller.stub(:current_user => create(:parent_user))
        get :index
      end

      it "response should be ok" do
        expect(response).to be_ok
      end

      it "@pricing_plans should be pricing plans for parents" do
        expect(assigns(:pricing_plans)).to match_array pricing_plans_for_parent
      end
    end

    context "when no user signed in" do
      before do
        controller.stub(:current_user => nil)
        get :index
      end

      it "response should be ok" do
        expect(response).to be_ok
      end

      it "@pricing_plans should be all pricing plans" do
        expect(assigns(:pricing_plans)).to match_array all_pricing_plans
      end
    end
  end
end
