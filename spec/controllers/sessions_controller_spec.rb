require 'spec_helper'

describe SessionsController do
  fixtures :users

  describe "POST 'create'" do
    before(:each) do
      @input_attributes = {
        email: "john@example.com",
        password: "password1",
        password_confirmation: "password1" }
    end

    it "Redirect to order if successfully login" do
      @user = users(:one)
      post :create, user: @input_attributes
      response.should redirect_to ('/')
    end

    it "Redirect to login_url if failed login" do
      @user = users(:two)
      post :create, user: @input_attributes
      response.should redirect_to(login_url)
    end

    it "Alert 'Invalid user/password combination' if failed login" do
      @user = users(:two)
      post :create, user: @input_attributes
      flash[:alert].should eq "Invalid user/password combination"
    end
  end

  describe "DELETE 'destroy'" do
    it "Redirect to user" do
      delete :destroy
      response.should redirect_to ('/')
    end
  end
end
