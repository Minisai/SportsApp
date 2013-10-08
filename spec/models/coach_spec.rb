require 'spec_helper'

describe Coach do
  it { should have_one(:user) }
  it { should have_many(:teams) }
  it { should have_many(:motivations) }
  it { should have_many(:assessments) }
  it { should have_many(:rewards) }

  it { should have_and_belong_to_many(:players) }

  describe :generate_program_code do
    let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
    let!(:coach) { create(:coach_user).role }

    it "program_code should be present" do
      expect(coach.program_code).to be_present
    end

    it "should send email" do
      expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 1
    end
  end

  describe :invite_player_with do
    let!(:coach) { create(:coach_user).role }
    let!(:player) { create(:player_user).role }

    let(:result) { coach.invite_player_with(params) }

    context "user is already in the system" do
      context "and he is player" do
        let(:params) { { :email => player.email } }
        context "first invitation from this coach" do
          it "success should be true" do
            expect(result[:success]).to be_true
          end

          it "message should be_blank" do
            expect(result[:message]).to be_blank
          end
        end
        context "duplicate invitation from this coach" do
          before { coach.invite_player_with(params) }

          it "success should be false" do
            expect(result[:success]).to be_false
          end

          it "message should be_present" do
            expect(result[:message]).to be_present
          end
        end
      end
      context "and he is coach" do
        let(:params) { { :email => create(:coach_user).email } }


        it "success should be false" do
          expect(result[:success]).to be_false
        end

        it "message should be_present" do
          expect(result[:message]).to eq "Coach or parent has been already registered with this email"
        end
      end
      context "and he is parent" do
        let(:params) { { :email => create(:parent_user).email } }


        it "success should be false" do
          expect(result[:success]).to be_false
        end

        it "message should be_present" do
          expect(result[:message]).to eq "Coach or parent has been already registered with this email"
        end
      end
    end

    context "user is not in the system" do
      context "and valid params are provided" do
        let(:params) { { :email => 'new_player@mail.com' } }

        it "success should be false" do
          expect(result[:success]).to be_true
        end

        it "message should be_blank" do
          expect(result[:message]).to be_blank
        end
      end
      context "and invalid params are provided" do
        let(:params) { { :email => 'invalid' } }

        it "success should be false" do
          expect(result[:success]).to be_false
        end

        it "message should be_blank" do
          expect(result[:message]).to be_present
        end
      end
    end
  end
end
