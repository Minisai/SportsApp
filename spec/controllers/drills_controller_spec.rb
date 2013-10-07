require 'spec_helper'

describe DrillsController do
  describe 'GET show' do
    context "valid id" do
      let!(:drill) { create(:drill) }
      let(:parsed_body) { JSON.parse(response.body) }
      before { get :show, :id => drill.id }

      it "should return drill" do
        expect(parsed_body).to eq JSON.parse(DrillSerializer.new(drill).to_json)
      end
    end

    context "invalid id" do
      it "should raise error" do
        expect { get :show, :id => 'invalid' }.to raise_error
      end
    end
  end
end
