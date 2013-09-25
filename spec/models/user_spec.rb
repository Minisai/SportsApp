require 'spec_helper'

describe User do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should_not allow_value(nil).for(:male) }
  it { should validate_presence_of(:birthday) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:role) }

  it { should validate_uniqueness_of(:username) }

  context "invited player" do
    before { User.any_instance.stub(:invited_player? => true) }

    it { should allow_value(nil).for(:username) }
    it { should allow_value(nil).for(:first_name) }
    it { should allow_value(nil).for(:last_name) }
    it { should allow_value(nil).for(:male) }
    it { should allow_value(nil).for(:birthday) }
    it { should allow_value(nil).for(:country) }
    it { should allow_value(nil).for(:role) }
  end

  it { should belong_to(:role) }
  it { should have_many(:payments) }

  describe "role methods" do
    context "question methods" do
      subject { create(:coach_user) }
      it { should respond_to(:coach?) }
      it { should respond_to(:parent?) }
      it { should respond_to(:player?) }
    end
  end

  describe "gender virtual attribute" do

    context "when male field is true" do
      let(:user) { create(:coach_user) }
      it "should fill gender as Male" do
        expect(user.gender).to eq 'Male'
      end

      context "and we update it with gender = 'Female' " do
        before {user.update_attribute(:gender, 'Female')}

        it "male field should be false" do
          expect(user.male).to be_false
        end
      end
      context "and we update it with gender = 'Robot' " do
        before {user.update_attribute(:gender, 'Robot')}

        it "male field should be true" do
          expect(user.male).to be_true
        end
      end
    end
    context "when male field is false" do
      let(:user) { create(:coach_user, :male => false) }

      it "should fill gender as Female" do
        expect(user.gender).to eq 'Female'
      end

      context "and we update it with gender = 'Male' " do
        before {user.update_attribute(:gender, 'Male')}

        it "male field should be true" do
          expect(user.male).to be_true
        end
      end
      context "and we update it with gender = 'Robot' " do
        before {user.update_attribute(:gender, 'Robot')}

        it "male field should be false" do
          expect(user.male).to be_false
        end
      end
    end
  end

  describe :paid? do
    context "when user's expired_at date >= today" do
      let(:user) { create(:player_user, :expired_at => 1.month.since)}

      it "should return true" do
        expect(user.paid?).to be_true
      end
    end
    context "when user's expired_at date == today" do
      let(:user) { create(:player_user, :expired_at => Date.today)}

      it "should return true" do
        expect(user.paid?).to be_true
      end
    end
    context "when user's expired_at date <= today" do
      let(:user) { create(:player_user, :expired_at => 1.day.ago)}

      it "should return true" do
        expect(user.paid?).to be_false
      end
    end
  end

  describe :name do
    let!(:user) { create(:player_user) }

    it "should return first_name + last_name" do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end
end
