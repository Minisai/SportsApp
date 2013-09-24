require 'spec_helper'

describe Coaches::TeamsController do
  let(:parsed_body) { JSON.parse(response.body) }

  describe "GET index" do
    let!(:coach) { create(:coach_user).role }
    let!(:coach_players) { create_list(:player, 10, :program_code => coach.program_code) }
    let!(:coach_teams) { create_list(:team, 3, :coach => coach)}

    context "coach signed in" do
      before do
        controller.stub(:current_user => coach.user)
        get :index
      end

      it "response should be ok" do
        expect(response).to be_ok
      end

      it "should assign coach players to @players variable" do
        expect(assigns(:players)).to match_array coach_players
      end

      it "should assign coach teams to @teams variable" do
        expect(assigns(:teams)).to match_array coach_teams
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => create(:parent_user)) }

      it "should raise error" do
        expect { get :index }.to raise_error
      end
    end

    context "player signed in" do
      before { controller.stub(:current_user => create(:player_user)) }

      it "should raise error" do
        expect { get :index }.to raise_error
      end
    end
  end

  describe "GET show" do
    let!(:coach) { create(:coach_user).role }
    let!(:coach_teams) { create_list(:team, 3, :coach => coach)}

    before { controller.stub(:current_user => coach.user) }

    context "valid team_id" do
      before { get :show, :id => coach_teams.last.id }
      it "should return json with team data" do
        expect(parsed_body).to eq JSON.parse(coach_teams.last.to_json)
      end
    end

    context "invalid team_id" do
      before { get :show, :id => 'invalid' }

      it "should return null" do
        expect(response.body).to eq "null"
      end
    end
  end

  describe "POST create" do
    let!(:coach) { create(:coach_user).role }

    before { controller.stub(:current_user => coach.user) }

    context "valid params" do
      let(:valid_params) {{:name => "New team", :description => "desc"}}
      let!(:initial_teams_count) { coach.teams.count }

      before { post :create, valid_params }

      it "response should be ok" do
        expect(response).to be_ok
      end

      it "should create new team" do
        expect(coach.teams.count - initial_teams_count).to eq 1
      end

      it "should return success message" do
        expect(parsed_body['message']).to eq "Team was successfully created"
      end

      it "should return new team list" do
        expect(parsed_body['teams']).to eq JSON.parse(coach.teams.to_json)
      end

      it "should return hash with message and teams keys" do
        expect(parsed_body.keys.sort).to eq %w(message teams).sort
      end
    end

    context "invalid params" do
      let(:invalid_params) {{:name => "", :description => "desc"}}
      let!(:initial_teams_count) { coach.teams.count }

      before { post :create, invalid_params }

      it "response should be ok" do
        expect(response).to be_bad_request
      end

      it "should not create new team" do
        expect(coach.teams.count - initial_teams_count).to eq 0
      end

      it "should return hash with message key" do
        expect(parsed_body.keys).to eq %w(message)
      end
    end
  end

end
