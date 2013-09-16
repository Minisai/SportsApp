require 'spec_helper'

describe Coaches::PlayersController do
  render_views

  let!(:coach) { create(:coach_user).role }
  let!(:players) { create_list(:player, 10, :coach => coach) }
  let!(:parent) { create(:parent_user).role }
  let!(:player) { create(:player_user).role }
  let!(:another_coach) { create(:coach_user).role }


  let(:player) { players.first }
  let(:parsed_body) { JSON.parse(response.body) }

  describe "GET 'index'" do
    context "coach singed in" do
      before do
        controller.stub(:current_user => coach.user)
        get :index
      end

      it { expect(response).to be_success }
      it { expect(assigns(:coach)).to eq coach }
      it { expect(assigns(:players)).to match_array players }

      it "should get json with keys" do
        expect(parsed_body.first.keys.sort).to eq %w(id name country last_sign_in_at email).sort
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
    context "coach singed in" do
      context "valid coach" do
        before do
          controller.stub(:current_user => coach.user)
          get :show, :id => player.id
        end
        it { expect(response).to be_success }
        it { expect(assigns(:coach)).to eq coach }
        it { expect(assigns(:player)).to eq player }

        it "should get json with keys" do
          expect(parsed_body['player'].keys.sort).to eq %w(id name country last_sign_in_at email).sort
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

  describe "POST 'send_message'" do
    context "coach singed in" do
      context "valid coach" do
        context "message is present" do
          let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
          before do
            controller.stub(:current_user => coach.user)
            xhr :post, :send_message, :id => player.id, :message => 'Hello!'
          end

          it { expect(response).to be_ok }

          it "should respond with message" do
            expect(parsed_body['message']).to eq "Message was sent successfully"
          end

          it "should send email" do
            expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 1
          end
        end

        context "message is blank" do
          let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
          before do
            controller.stub(:current_user => coach.user)
            xhr :post, :send_message, :id => player.id, :message => nil
          end

          it { expect(response).to be_bad_request }

          it "should respond with message" do
            expect(parsed_body['message']).to eq "Message required"
          end

          it "should not send email" do
            expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 0
          end
        end
      end
      context "wrong coach" do
        before do
          controller.stub(:current_user => another_coach.user)
        end
        it "should raise error" do
          expect { xhr :post, :send_message, :id => player.id }.to raise_error
        end
      end
    end
    context "player signed in" do
      before { controller.stub(:current_user => player.user) }

      it "should raise error" do
        expect { xhr :post, :send_message, :id => player.id }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => parent.user) }

      it "should raise error" do
        expect { xhr :post, :send_message, :id => player.id }.to raise_error
      end
    end
  end

  describe "POST 'motivate'" do
    context "coach singed in" do
      context "valid coach" do
        context "message is present, id is 'new'" do
          let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
          let!(:initial_motivations_count) { coach.motivations.count }
          let(:motivation_params) do {
              :message => 'Hello!',
              :id => 'new'
            }
          end
          before do
            controller.stub(:current_user => coach.user)
            xhr :post, :motivate, :id => player.id, :motivation => motivation_params
          end

          it { expect(response).to be_ok }

          it "should respond with message" do
            expect(parsed_body['message']).to eq "Motivation was sent successfully"
          end

          it "should respond with motivations list" do
            expect(parsed_body['motivations']).to eq JSON.parse(coach.motivations.to_json)
          end

          it "should send email" do
            expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 1
          end

          it "should create motivation" do
            expect(coach.motivations.count - initial_motivations_count).to eq 1
          end
        end

        context "message is blank, id is present" do
          let!(:motivation) { create(:motivation, :coach => coach) }
          let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
          let!(:initial_motivations_count) { Motivation.count }
          let(:motivation_params) do {
              :message => nil,
              :id => motivation.id
          }
          end
          before do
            controller.stub(:current_user => coach.user)
            xhr :post, :motivate, :id => player.id, :motivation => motivation_params
          end

          it { expect(response).to be_ok }

          it "should respond with message" do
            expect(parsed_body['message']).to eq "Motivation was sent successfully"
          end

          it "should respond with motivations list" do
            expect(parsed_body['motivations']).to eq JSON.parse(coach.motivations.to_json)
          end

          it "should send email" do
            expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 1
          end

          it "should not create motivation" do
            expect(Motivation.count - initial_motivations_count).to eq 0
          end
        end

        context "message is present but record is already exist" do
          let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
          let(:motivation_params) do {
              :message => 'Hello!',
              :id => 'new'
          }
          end
          before do
            create(:motivation, :coach => coach, :message => motivation_params[:message])
            controller.stub(:current_user => coach.user)
            xhr :post, :motivate, :id => player.id, :motivation => motivation_params
          end
          let!(:initial_motivations_count) { Motivation.count }

          it { expect(response).to be_ok }

          it "should respond with message" do
            expect(parsed_body['message']).to eq "Motivation was sent successfully"
          end

          it "should respond with motivations list" do
            expect(parsed_body['motivations']).to eq JSON.parse(coach.motivations.to_json)
          end

          it "should send email" do
            expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 1
          end

          it "should not create motivation" do
            expect(Motivation.count - initial_motivations_count).to eq 0
          end
        end

        context "message is blank, id is new" do
          let!(:initial_mails_count) { ActionMailer::Base.deliveries.count }
          let!(:initial_motivations_count) { Motivation.count }
          let(:motivation_params) do {
              :message => nil,
              :id => 'new'
          }
          end
          before do
            controller.stub(:current_user => coach.user)
            xhr :post, :motivate, :id => player.id, :motivation => motivation_params
          end

          it { expect(response).to be_bad_request }

          it "should respond with message" do
            expect(parsed_body['message']).to eq "Select motivation or provide message"
          end

          it "should respond with motivations list" do
            expect(parsed_body['motivations']).to eq nil
          end

          it "should not send email" do
            expect(ActionMailer::Base.deliveries.count - initial_mails_count).to eq 0
          end

          it "should not create motivation" do
            expect(Motivation.count - initial_motivations_count).to eq 0
          end
        end
      end

      context "wrong coach" do
        before do
          controller.stub(:current_user => another_coach.user)
        end
        it "should raise error" do
          expect { xhr :post, :motivate, :id => player.id }.to raise_error
        end
      end
    end
    context "player signed in" do
      before { controller.stub(:current_user => player.user) }

      it "should raise error" do
        expect { xhr :post, :motivate, :id => player.id }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => parent.user) }

      it "should raise error" do
        expect { xhr :post, :motivate, :id => player.id }.to raise_error
      end
    end
  end

end
