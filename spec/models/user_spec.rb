require 'spec_helper'

describe User do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:name) }
  it { should_not allow_value(nil).for(:male) }
  it { should validate_presence_of(:birthday) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:role) }

  it { should validate_uniqueness_of(:username) }

  it { should belong_to(:role) }

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
end
