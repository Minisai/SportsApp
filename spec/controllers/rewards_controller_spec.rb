require 'spec_helper'

describe RewardsController do
  render_views
  let(:parsed_body) { JSON.parse(response.body) }
  let(:reward) { create(:reward) }
  describe 'GET show' do
    context "valid_id" do
      before { get :show, :id => reward.id }

      it { expect(response).to be_success }
      it { expect(assigns(:reward)).to eq reward }

      it "should get json with keys" do
        expect(parsed_body['reward'].keys.sort).to eq %w(id name description image_url reward_image_id).sort
      end
    end
  end
end
