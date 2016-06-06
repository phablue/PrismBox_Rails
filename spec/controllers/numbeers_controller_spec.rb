require 'rails_helper'

RSpec.describe NumbeersController, type: :controller do

  describe "GET #fibonacci" do
    it "returns http success" do
      get :fibonacci
      expect(response).to have_http_status(:success)
    end
  end

end
