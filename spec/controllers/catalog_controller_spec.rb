require 'rails_helper'

describe CatalogController do
  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it "returns HTTP 200 status code" do
      get :index
      response.status.should be 200
    end
  end
end
