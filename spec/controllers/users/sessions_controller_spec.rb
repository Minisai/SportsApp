require 'spec_helper'

describe Users::SessionsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe :create do
    let(:password) { '123456789' }

    let(:valid_params) do
      {
          :user => {
              :email => user.email,
              :password => password
          }
      }
    end

    let(:invalid_params) do
      {
          :user => {
              :email => 'invalid@invalid.com',
              :password => 'invalid_password'
          }
      }
    end

    context 'player user' do
      let!(:user) { create(:player_user, :password => password) }

      context 'with valid params' do
        it 'should sign in successfully' do
          post :create, valid_params
          expect(response).to redirect_to :root
          expect(flash[:alert]).to be_blank
        end
      end

      context 'with case-insensitive email' do
        it 'should sign in successfully' do
          params = valid_params.dup
          params[:user][:email].upcase!
          post :create, params
          expect(response).to redirect_to :root
          expect(flash[:alert]).to be_blank
        end
      end

      context 'with invalid params' do
        it "shouldn't sign in" do
          post :create, invalid_params
          expect(response).to render_template 'new'
          expect(flash[:alert]).to be_present
        end
      end
    end

    context 'coach user' do
      let!(:user) { create(:coach_user, :password => password) }

      context 'with valid params' do
        it 'should sign in successfully' do
          post :create, valid_params
          expect(response).to redirect_to :root
          expect(flash[:alert]).to be_blank
        end
      end
    end

    context 'parent user' do
      let!(:user) { create(:parent_user, :password => password) }

      context 'with valid params' do
        it 'should sign in successfully' do
          post :create, valid_params
          expect(response).to redirect_to :root
          expect(flash[:alert]).to be_blank
        end
      end
    end
  end
end