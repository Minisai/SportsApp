require 'spec_helper'

describe Coaches::DashboardsController do
  let!(:coach) { create(:coach_user).role }
  let!(:team) { create(:team, :coach => coach) }
  let!(:players) { create_list(:player, 10, :program_code => coach.program_code) }
  before { team.players << players }
  let!(:parent) { create(:parent_user).role }
  let!(:player) { create(:player_user).role }

  describe "GET 'show'" do
    context "coach singed in" do
      before do
        controller.stub(:current_user => coach.user)
        get :show
      end

      it { expect(response).to be_success }
      it { expect(assigns(:team)).to eq team }
      it { expect(assigns(:players)).to match_array players }
    end
    context "player signed in" do
      before { controller.stub(:current_user => player.user) }

      it "should raise error" do
        expect { get :show }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => parent.user) }

      it "should raise error" do
        expect { get :show }.to raise_error
      end
    end
  end

end
