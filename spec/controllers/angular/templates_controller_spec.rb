require 'spec_helper'

describe Angular::TemplatesController do
  describe 'GET show' do
    context "template exists" do
      before { get :show, :id => 'motivation_modal' }
      it "should be rendered" do
        expect(response).to render_template(:motivation_modal)
      end
    end

    context "invalid template" do
      it "should raise error" do
        expect { get :show, :id => 'INVALID' }.to raise_error
      end
    end
  end
end
