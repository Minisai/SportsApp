require 'spec_helper'

describe Coaches::RewardsController do
  let!(:coach) { create(:coach_user).role }

  describe "GET index" do
    let!(:admin) { create(:admin_user).role }
    let!(:admin_rewards) { create_list(:reward, 10, :creator => admin) }
    let!(:coach_rewards) { create_list(:reward, 5, :creator => coach) }
    let!(:admin_reward_images) { create_list(:reward_image, 10, :creator => admin) }
    let!(:coach_reward_images) { create_list(:reward_image, 5, :creator => coach) }

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      before { get :index }

      it "should assign coach_rewards to @rewards" do
        expect(assigns(:rewards)).to match_array coach_rewards
      end
      it "should assign admin_rewards to @default_rewards" do
        expect(assigns(:default_rewards)).to match_array admin_rewards
      end
      it "should assign admin_rewards to @default_rewards" do
        expect(assigns(:reward_images)).to match_array(admin_reward_images + coach_reward_images)
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

  describe "POST :create" do
    let!(:reward_image) { create(:reward_image, :creator => coach) }

    let(:valid_params) do
      { :reward => {
          :name => "Name",
          :description => "Description",
          :reward_image_id => reward_image.id.to_s
      }}
    end

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { post :create, valid_params } }

        it "should create new reward record" do
          should change { Reward.count }.by(1)
        end
      end

      context "invalid params" do
        let(:invalid_params) { valid_params.merge(:reward => {:name => nil}) }
        subject { -> { post :create, invalid_params } }

        it "should not create new reward record" do
          should_not change { Reward.count }
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
    let!(:old_reward_image) { create(:reward_image, :creator => coach) }
    let!(:new_reward_image) { create(:reward_image, :creator => coach) }
    let!(:reward) { create(:reward, :name => 'old_name', :reward_image => old_reward_image, :creator => coach) }

    let(:valid_params) do
      {
          :id => reward.id,
          :reward => {
              :id => reward.id,
              :name => "new_name",
              :description => "Description",
              :reward_image_id => new_reward_image
          }}
    end

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { put :update, valid_params } }

        it "should change reward record" do
          should change { reward.reload.name }.from('old_name').to('new_name')
        end
        it "should change reward record reward_image too" do
          should change { reward.reload.reward_image }.from(old_reward_image).to(new_reward_image)
        end
      end

      context "invalid params" do
        let(:invalid_params) { valid_params.merge(:reward => {:name => nil}) }
        subject { -> { put :update, invalid_params } }

        it "should not change new reward record" do
          should_not change { reward.reload.name }
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
    let!(:reward) { create(:reward, :reward_image => reward_image, :creator => coach) }

    let(:valid_params) {{ :id => reward.id }}

    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        subject { -> { delete :destroy, valid_params } }

        it "should destroy reward record" do
          should change { Reward.count }.by(-1)
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
