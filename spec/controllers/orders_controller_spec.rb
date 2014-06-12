require 'spec_helper'

describe OrdersController do
  fixtures :orders

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

  describe "POST 'create'" do
    before(:each) do
      post :create, order: {name: "Sara", email: "sara2@example.com", laptop_number: "pro9876"}
    end

    it "Redirect to order" do
      response.should redirect_to assigns(:order)
    end

    it "Flash notice message is 'Successfully ordered.' when Redirect to" do
      flash[:notice].should include "Successfully ordered"
    end
  end
end
