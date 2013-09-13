require 'spec_helper'

describe Player do
  it { should validate_presence_of(:coach) }

  it { should have_one(:user) }
  it { should belong_to(:coach) }
  it { should belong_to(:parent) }
  it { should belong_to(:team) }

  it { should have_many(:motivation_players) }
  it { should have_many(:motivations).through(:motivation_players) }

  describe :add_program_code_error_to_user do
    let(:invalid_player) { build(:player, :coach => nil) }

    context "when player has user" do
      let!(:user) { build(:user, :role => invalid_player) }

      it "should add error on program_code to user" do
        invalid_player.valid?
        expect(user.errors[:program_code]).to be_present
      end
    end
  end

  describe :with_team do
    before { create_list(:player, 10) }
    let!(:team) { create(:team) }
    let!(:players_with_one_team) { create_list(:player, 10, :team => team) }

    it "should return players scoped to specified team_id" do
      expect(Player.with_team(players_with_one_team.last.team_id)).to match_array(players_with_one_team)
    end
  end
end
