require 'spec_helper'

describe PlanItem do
  it { should validate_presence_of(:item) }
  it { should belong_to(:item) }
  it { should belong_to(:plan) }

  context :build_form do
    let!(:coach) { create(:coach_user).role }
    let!(:drills) { create_list(:drill, 4) }
    let!(:reward) { create(:reward, :creator => coach) }
    let!(:assessment) { create(:assessment, :creator => coach) }

    let(:valid_params) do
      [ {
          :item_type => "PlanSession",
          :days_attributes =>
            [{:exercises_attributes =>
                [{:drill_id => drills[0].id, :repetitions => 5},
                 {:drill_id => drills[1].id, :repetitions => 5}]
             },
             {:exercises_attributes =>
                [{:drill_id => drills[2].id, :repetitions => 5},
                 {:drill_id => drills[3].id, :repetitions => 5}]
             }]
        },
        {
          :item_type => "PlanSession",
          :days_attributes =>
            [{:exercises_attributes =>
                [{:drill_id => drills[0].id, :repetitions => 10},
                 {:drill_id => drills[1].id, :repetitions => 10}]
             },
             {:exercises_attributes =>
                [{:drill_id => drills[2].id, :repetitions =>10},
                 {:drill_id => drills[3].id, :repetitions =>10}]
             }]
        },
        {:id => assessment.id, :item_type => "Assessment"},
        {:id => reward.id, :item_type => "Reward"}
      ]
    end

    subject { -> { PlanItem.build_from(valid_params) } }

    it "should create new plan_sessions records" do
      should change { PlanSession.count }.by(2)
    end
    it "should create new days records" do
      should change { Day.count }.by(4)
    end
    it "should create new exercises records" do
      should change { Exercise.count }.by(8)
    end

    it "should build 4 records" do
      expect(PlanItem.build_from(valid_params).count).to eq 4
    end
  end

  context :destroy_plan_session do
    let!(:coach) { create(:coach_user).role }
    let!(:plan) { create(:plan, :with_plan_items, :creator => coach) }

    subject { -> { plan.destroy } }

    it "should destroy some plan_items records" do
      should change { PlanItem.count }.by(-5)
    end
    it "should destroy some plan_sessions records" do
      should change { PlanSession.count }.by(-3)
    end
    it "should destroy some days records" do
      should change { Day.count }.by(-2*3)
    end
    it "should destroy some exercises records" do
      should change { Exercise.count }.by(-2*3*5)
    end
    it "should not destroy rewards records" do
      should_not change { Reward.count }
    end
    it "should not destroy assessments records" do
      should_not change { Assessment.count }
    end
  end
end
