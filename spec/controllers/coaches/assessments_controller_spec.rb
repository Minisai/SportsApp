require 'spec_helper'

describe Coaches::AssessmentsController do
  let!(:coach) { create(:coach_user).role }

  describe "GET :new" do
    let!(:drills) { create_list(:drill, 10) }
    before { controller.stub(:current_user => coach.user) }
    before { get :new }

    it "should assigns all drills to drills" do
      expect(assigns(:drills)).to match_array(drills)
    end
  end

  describe "POST :create" do
    let!(:drill) { create(:drill) }

    let(:valid_params) do
      { :assessment => {
          :name => "Name",
          :description => "Description",
          :exercises_attributes => [{
                  :drill_id => drill.id,
                  :repetitions => 5
          }]
      }}
    end

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { post :create, valid_params } }

        it "should create new assessment record" do
          should change { Assessment.count }.by(1)
        end
      end

      context "invalid params" do
        let(:invalid_params) { valid_params.merge(:assessment => {:name => nil}) }
        subject { -> { post :create, invalid_params } }

        it "should not create new assessment record" do
          should_not change { Assessment.count }
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
