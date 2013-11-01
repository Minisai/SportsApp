require 'spec_helper'

describe Coaches::PlansController do
  let!(:coach) { create(:coach_user).role }
  let!(:drills) { create_list(:drill, 10) }
  let!(:rewards) { create_list(:reward, 20, :creator => create(:admin)) + create_list(:reward, 10, :creator => coach) }
  let!(:assessments) { create_list(:assessment, 10, :creator => coach) }

  describe "GET :new" do
    before do
      controller.stub(:current_user => coach.user)
      get :new
    end

    it "should assigns all drills to drills" do
      expect(assigns(:drills)).to match_array(drills)
    end
    it "should assigns coach + admin rewards to rewards" do
      expect(assigns(:rewards)).to match_array(rewards)
    end
    it "should assign coach's assessments'" do
      expect(assigns(:assessments)).to match_array(assessments)
    end
  end

  describe 'POST create' do
    let(:valid_params) do
      {
        :plan => {:name =>"New Plan"},
        :plan_items =>
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
            {:id => assessments[0].id, :item_type => "Assessment"},
            {:id => rewards[0].id, :item_type => "Reward"}
          ]
      }
    end

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { post :create, valid_params } }

        it "should create new plan record" do
          should change { Plan.count }.by(1)
        end
        it "should create new plan_items records" do
          should change { PlanItem.count }.by(valid_params[:plan_items].count)
        end
        it "should create new plan_sessions records" do
          should change { PlanSession.count }.by(2)
        end
        it "should create new days records" do
          should change { Day.count }.by(4)
        end
        it "should create new exercises records" do
          should change { Exercise.count }.by(8)
        end
      end

      context "invalid params" do
        let(:invalid_params) { valid_params.merge(:plan => {:name => nil}) }
        subject { -> { post :create, invalid_params } }

        it "should not create new plan record" do
          should_not change { Plan.count }
        end
        it "should not create new plan_items records" do
          should_not change { PlanItem.count }
        end
        it "should not create new plan_sessions records" do
          should_not change { PlanSession.count }
        end
        it "should not create new days records" do
          should_not change { Day.count }
        end
        it "should not create new exercises records" do
          should_not change { Exercise.count }
        end
      end
    end

    context "player signed in" do
      before { controller.stub(:current_user => create(:player)) }

      it "should raise error" do
        expect { post :create, valid_params }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => create(:parent)) }

      it "should raise error" do
        expect { post :create, valid_params }.to raise_error
      end
    end
  end
end
