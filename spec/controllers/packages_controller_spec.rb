require 'rails_helper'

RSpec.describe PackagesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "gets all the packages" do
      allow(Package).to receive(:all).and_return('foo')

      get :index
      expect(assigns(:packages)).to eq('foo')
    end
  end

end
