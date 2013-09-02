require 'spec_helper'

describe Player do
  it { should validate_presence_of(:coach) }

  it { should have_one(:user) }
  it { should belong_to(:coach) }
  it { should belong_to(:parent) }

  context :add_program_code_error_to_user do
    let(:invalid_player) { build(:player, :coach => nil) }

    context "when player has user" do
      let!(:user) { build(:user, :role => invalid_player) }

      it "should add error on program_code to user" do
        invalid_player.valid?
        expect(user.errors[:program_code]).to be_present
      end
    end
  end
end
