require 'spec_helper'

describe Coaches::PlayersController do
  render_views

  let!(:coach) { create(:coach_user).role }
  let!(:players) { create_list(:player, 10, :coach => coach) }
  let!(:parent) { create(:parent_user).role }
  let!(:player) { create(:player_user).role }
  let!(:another_coach) { create(:coach_user).role }

  describe "GET 'index'" do
    context "coach singed in" do
      before do
        controller.stub(:current_user => coach.user)
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:coach)).to eq coach }
      it { expect(assigns(:players)).to match_array players }

      let(:parsed_body) { JSON.parse(response.body) }

      it "should get json with keys" do
        expect(parsed_body.first['player'].keys.sort).to eq %w(id name last_sign_in_at).sort
      end
    end
    context "player signed in" do
      before { controller.stub(:current_user => player.user) }

      it "should raise error" do
        expect { get :index }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => parent.user) }

      it "should raise error" do
        expect { get :index }.to raise_error
      end
    end
  end

  describe "GET 'show'" do
    let(:player) { players.first }

    context "coach singed in" do
      context "valid coach" do
        before do
          controller.stub(:current_user => coach.user)
          get :show, :id => player.id
        end
        it { expect(response).to be_success }
        it { expect(assigns(:coach)).to eq coach }
        it { expect(assigns(:player)).to eq player }

        let(:parsed_body) { JSON.parse(response.body) }

        it "should get json with keys" do
          expect(parsed_body['player'].keys.sort).to eq %w(id name last_sign_in_at).sort
        end
      end
      context "wrong coach" do
        before do
          controller.stub(:current_user => another_coach.user)
        end
        it "should raise error" do
          expect { get :show, :id => player.id }.to raise_error
        end
      end
    end
    context "player signed in" do
      before { controller.stub(:current_user => player.user) }

      it "should raise error" do
        expect { get :show, :id => player.id }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => parent.user) }

      it "should raise error" do
        expect { get :show, :id => player.id }.to raise_error
      end
    end
  end

end
