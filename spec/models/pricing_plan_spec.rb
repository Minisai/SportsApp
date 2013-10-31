require 'spec_helper'

describe PricingPlan do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:role_type) }
  it { should validate_presence_of(:cost) }
  it { should validate_presence_of(:duration) }
  it { should validate_uniqueness_of(:name).scoped_to(:role_type) }

  it { should have_many(:payments) }

  describe :with_pricing_plans_for do
    let!(:pricing_plans_for_player) { create_list(:pricing_plan_for_player, 4) }
    let!(:pricing_plans_for_coach) { create_list(:pricing_plan_for_coach, 4) }
    let!(:pricing_plans_for_parent) { create_list(:pricing_plan_for_parent, 4) }

    context "for player user" do
      let(:player_user) { create(:player_user)}

      it "should return only pricing plans for player" do
        expect(PricingPlan.with_role_type_for(player_user)).to match_array(pricing_plans_for_player)
      end
    end

    context "for coach user" do
      let(:coach_user) { create(:coach_user)}

      it "should return only pricing plans for coach" do
        expect(PricingPlan.with_role_type_for(coach_user)).to match_array(pricing_plans_for_coach)
      end
    end

    context "for parent user" do
      let(:parent_user) { create(:parent_user)}

      it "should return only pricing plans for parent" do
        expect(PricingPlan.with_role_type_for(parent_user)).to match_array(pricing_plans_for_parent)
      end
    end
  end
end
