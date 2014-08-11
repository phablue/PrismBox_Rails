require 'rails_helper'

describe OrdersController do
  fixtures :orders
  fixtures :users

  before(:each) {
    auth_with :admin
  }

  after(:each) {
    clear_auth
  }

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
      post :create, order: {full_name: "Sara", email: "sara2@example.com", laptop_serial_number: "pro9876"}
    end

    it "Redirect to order" do
      response.should redirect_to assigns(:order)
    end

    it "Flash notice message is 'Successfully ordered.' when Redirect to" do
      flash[:notice].should include "Successfully ordered"
    end
  end

  describe "POST 'update'" do
    before(:each) do
      orders(:one).full_name.should eq "John"
      post :update, id: orders(:one).id, order: {full_name: "Mike"}
      orders(:one).reload
    end

    it "Redirect to order" do
      response.should redirect_to assigns(:order)
    end

    it "Flash notice message is 'Order was successfully updated.' when Redirect to" do
      flash[:notice].should include "Order was successfully updated."
    end
  end

  describe "DELETE 'destroy'" do
    it "Delete Order(:one)" do
      expect {delete :destroy, id: orders(:one).id}.to change(Order,:count).by(-1)
    end

    it "Redirect to user" do
      delete :destroy, id: orders(:one).id
      response.should redirect_to ('/')
    end
  end
end
