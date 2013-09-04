require 'spec_helper'

describe Player do
  it { should validate_presence_of(:coach) }

  it { should have_one(:user) }
  it { should belong_to(:coach) }
  it { should belong_to(:parent) }
  it { should belong_to(:team) }

  it { should delegate_method(:name).to(:user).as(:name) }
  it { should delegate_method(:last_sign_in_at).to(:user).as(:last_sign_in_at) }

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
