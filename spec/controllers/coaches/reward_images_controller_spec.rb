require 'spec_helper'

describe Coaches::RewardImagesController do
  let!(:coach) { create(:coach_user).role }
  describe "POST :create" do
    let(:valid_params) { {
      :file => Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/reward_image/valid.png'), 'image/png')
    } }
    let(:invalid_params) { {
        :file => Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/files/reward_image/invalid.txt'), 'image/png')
    } }

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { post :create, valid_params } }

        it "should create new assessment record" do
          should change { RewardImage.count }.by(1)
        end
      end

      context "invalid params" do
        subject { -> { post :create, invalid_params } }

        it "should not create new assessment record" do
          should_not change { RewardImage.count }
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
    let!(:reward_image) { create(:reward_image, :creator => coach) }

    let(:valid_params) {{ :id => reward_image.id }}

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { delete :destroy, valid_params } }

        it "should destroy assessment record" do
          should change { RewardImage.count }.by(-1)
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
