require 'spec_helper'

describe Coaches::Teams::PlayersController do
  let!(:coach) { create(:coach_user).role }
  let!(:team) { create(:team, :coach => coach) }
  let!(:players) { create_list(:player, 10, :coach => coach) }
  let!(:player) { players.last }


  describe "POST 'create'" do
    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        context "player was unassigned" do
          before { player.update_attributes(:team => nil) }

          it "should assign player to team" do
            expect { post :create, :team_id => team.id, :player_id => player.id }.to change { player.reload.team }.from(nil).to(team)
          end
        end

        context "player was assigned to another team" do
          let(:another_team) { create(:team, :coach => coach) }
          before { player.update_attributes(:team => another_team) }

          it "should reassign player to passed team" do
            expect { post :create, :team_id => team.id, :player_id => player.id }.to change { player.reload.team }.from(another_team).to(team)
          end
        end
      end

      context "invalid params" do
        context "coach trying to gain access to another coach's team" do
          before { controller.stub(:current_user => create(:coach_user)) }

          it "should raise error" do
            expect { post :create, :team_id => team, :player_id => player.id }.to raise_error
          end
        end

        context "team doesn't exists" do
          it "should raise error" do
            expect { post :create, :team_id => 'invalid', :player_id => player.id }.to raise_error
          end
        end

        context "player doesn't exists" do
          it "should raise error" do
            expect { post :create, :team_id => team, :player_id => 'invalid' }.to raise_error
          end
        end
      end
    end

    context "player signed in" do
      before { controller.stub(:current_user => create(:player_user)) }

      it "should raise error" do
        expect { post :create, :team_id => team, :player_id => player.id }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => create(:parent_user)) }

      it "should raise error" do
        expect { post :create, :team_id => team, :player_id => player.id }.to raise_error
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "coach signed in" do
      before { controller.stub(:current_user => coach.user) }

      context "valid params" do
        before { player.update_attributes(:team => team) }

        it "should unassign player from team" do
          expect { delete :destroy, :team_id => team, :id => player.id }.to change { player.reload.team }.from(team).to(nil)
        end
      end

      context "invalid params" do
        context "coach trying to gain access to another coach's team" do
          before { controller.stub(:current_user => create(:coach_user)) }

          it "should raise error" do
            expect { delete :destroy, :team_id => team, :id => player.id }.to raise_error
          end
        end

        context "team doesn't exists" do
          it "should raise error" do
            expect { delete :destroy, :team_id => team, :id => player.id }.to raise_error
          end
        end

        context "player doesn't exists" do
          it "should raise error" do
            expect { delete :destroy, :team_id => team, :id => 'invalid' }.to raise_error
          end
        end
      end
    end

    context "player signed in" do
      before { controller.stub(:current_user => create(:player_user)) }

      it "should raise error" do
        expect { delete :destroy, :team_id => team, :id => player.id }.to raise_error
      end
    end

    context "parent signed in" do
      before { controller.stub(:current_user => create(:parent_user)) }

      it "should raise error" do
        expect { delete :destroy, :team_id => team, :id => player.id }.to raise_error
      end
    end

  end
end