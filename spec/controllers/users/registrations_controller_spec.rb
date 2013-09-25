require 'spec_helper'

describe Users::RegistrationsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe :new do
    context "Anonymous" do
      it "should be redirected to welcome page" do
        get :new
        expect(response).to render_template 'new'
      end
    end

    context "Existed user" do
      before(:each) do
        controller.stub(:current_user => create(:player_user))
      end

      it "should be redirected to welcome page" do
        get :new
        expect(response).to render_template 'new'
      end
    end
  end

  describe :create do
    let(:params) do
      {
          :user => {
              :first_name => "first_name",
              :last_name => 'last_name',
              :email => "user@mail.com",
              :username => "Username",
              :password => '123456789',
              :password_confirmation => '123456789',
              :gender => 'Male',
              :birthday => 10.years.ago,
              :country => "Belarus"
          }
      }
    end

    context "when Player user tries to register" do
      let(:coach_user) { create(:coach_user) }
      let!(:valid_params) do
        params.merge( { :role_type => 'Player',
                        :program_code => coach_user.role.program_code })
      end

      context "with valid params" do
        it "should create player user" do
          expect{ post :create, valid_params }.to change(User, :count).by(1)
          expect(User.last.role).to be_an_instance_of(Player)
          expect(response).to redirect_to(:root)
        end
      end

      context "with invalid params" do
        let!(:invalid_params) { valid_params.merge({:user => {:password => ''}}) }

        it "should not create player user" do
          expect { post :create, invalid_params }.not_to change(User, :count)
          expect(response).to render_template 'new'
        end
      end

      context "with invalid PROGRAM_CODE" do
        let!(:params_with_invalid_program) { valid_params.merge({:program_code => 'INVALID'}) }

        it "should not create player user" do
          expect { post :create, params_with_invalid_program }.not_to change(User, :count)
          expect(assigns(:user).errors[:program_code]).to be_present
          expect(response).to render_template 'new'
        end
      end
    end

    context "when Parent user tries to register" do
      let!(:valid_params) { params.merge({:role_type => 'Parent'}) }
      context "with valid params" do

        it "should create parent user" do
          expect{ post :create, valid_params }.to change(User, :count).by(1)
          expect(User.last.role).to be_an_instance_of(Parent)
          expect(response).to redirect_to(:root)
        end
      end

      context "with invalid params" do
        let!(:invalid_params) { valid_params.merge({:user => {:password => ''}}) }

        it "should not create parent user" do
          expect { post :create, invalid_params }.not_to change(User, :count)
          expect(response).to render_template 'new'
        end
      end
    end

    context "when Coach user tries to register" do
      let!(:valid_params) { params.merge({:role_type => 'Coach'}) }

      context "with valid params" do
        it "should create coach user" do
          expect{ post :create, valid_params }.to change(User, :count).by(1)
          expect(User.last.role).to be_an_instance_of(Coach)
          expect(response).to redirect_to(:root)
        end
      end

      context "with invalid params" do
        let!(:invalid_params) { valid_params.merge({:user => {:password => ''}}) }

        it "should not create coach user" do
          expect { post :create, invalid_params }.not_to change(User, :count)
          expect(response).to render_template 'new'
        end
      end

      context "when invalid role_type" do
        context "role type is blank" do
          let!(:params_without_role_type) { params.merge({:role_type => ''}) }

          it "should not create any user" do
            expect { post :create, params_without_role_type }.not_to change(User, :count)
            expect(flash[:alert]).to be_present
            expect(response).to render_template 'new'
          end
        end

        context "role type is invalid" do
          let!(:params_with_invalid_role_type) { params.merge({:role_type => 'INVALID_ROLE'}) }

          it "should not create any user" do
            expect { post :create, params_with_invalid_role_type }.not_to change(User, :count)
            expect(flash[:alert]).to be_present
            expect(response).to render_template 'new'
          end
        end
      end
    end

  end
end