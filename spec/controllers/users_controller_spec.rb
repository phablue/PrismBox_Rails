require 'rails_helper'

describe UsersController do
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

  describe "GET 'show'" do
    it "Assigns the requested laptop to users(:one)" do
      get :show, id: users(:one).id
      assigns(:user).should eq users(:one)
    end
  end

  describe "POST 'create'" do
    before(:each) {
      post :create, user: {first_name: "Sara", last_name: "Mong", email: "sara2@example.com", password: "password3", password_confirmation: "password3", department: "Software"}
    }

    it "Redirect to user" do
      response.should redirect_to assigns(:user)
    end

    it "Flash notice message is 'Laptop was successfully created.' when Redirect to" do
      flash[:notice].should include "was successfully created."
    end
  end

  describe "POST 'update'" do
    before(:each) {
      users(:one).first_name.should eq "John"
      post :update, id: users(:one).id, user: {first_name: "Mike"}
      users(:one).reload
    }

    it "users(:one).first_name changed to Mike" do
      users(:one).first_name.should eq "Mike"
    end

    it "Redirect to user" do
      response.should redirect_to assigns(:user)
    end

    it "Flash notice message is 'Laptop was successfully created.' when Redirect to" do
      flash[:notice].should include "was successfully updated."
    end
  end

  describe "Delete 'destroy'" do
    it "Delete users(:one)" do
      expect {delete :destroy, id: users(:one).id}.to change(User,:count).by(-1)
    end

    it "Redirect to user" do
      delete :destroy, id: users(:one).id
      response.should redirect_to ('/')
    end
  end
end
