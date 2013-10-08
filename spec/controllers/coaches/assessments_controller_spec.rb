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

  describe 'PUT update' do
    let!(:drill) { create(:drill) }
    let!(:assessment) { create(:assessment, :name => 'old_name') }
    let!(:exercise) { create(:exercise, :repetitions => 5, :drill => drill, :assessment => assessment) }

    let(:valid_params) do
      {
          :id => assessment.id,
          :assessment => {
            :id => assessment.id,
            :name => "new_name",
            :description => "Description",
            :exercises_attributes => [{
                                          :id => exercise.id,
                                          :repetitions => 10
                                      }]
      }}
    end

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { put :update, valid_params } }

        it "should change assessment record" do
          should change { assessment.reload.name }.from('old_name').to('new_name')
        end
        it "should change assessment record exercises too" do
          should change { exercise.reload.repetitions }.from(5).to(10)
        end
      end

      context "invalid params" do
        let(:invalid_params) { valid_params.merge(:assessment => {:name => nil}) }
        subject { -> { put :update, invalid_params } }

        it "should not change new assessment record" do
          should_not change { assessment.reload.name }
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

  describe 'delete DESTROY' do
    let!(:drill) { create(:drill) }
    let!(:assessment) { create(:assessment) }
    let!(:exercise) { create(:exercise, :drill => drill, :assessment => assessment) }

    let(:valid_params) {{ :id => assessment.id }}

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { delete :destroy, valid_params } }

        it "should destroy assessment record" do
          should change { Assessment.count }.by(-1)
        end
      end
    end

    context "player signed in" do
      before { controller.stub(:current_user => create(:player)) }

      it "should raise error" do
        expect { delete :destroy, valid_params }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => create(:parent)) }

      it "should raise error" do
        expect { delete :destroy, valid_params }.to raise_error
      end
    end
  end
end
