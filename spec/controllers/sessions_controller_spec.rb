require 'rails_helper'

describe SessionsController do
  fixtures :users

  describe "POST 'create'" do
    before(:each) {
      @user = users(:one)
    }

    context "If successfully login" do
      it "user email equals session[:user_id]" do
        @user.email.should_not eq session[:user_id]

        post :create, email: @user.email, password: "password1"

        @user.email.should eq session[:user_id]
      end

      it "Redirect to order" do
        post :create, email: @user.email, password: "password1"

        response.should redirect_to '/'
      end
    end

    context "If failed login" do
      it "session[:user_id] is nil" do
        post :create, email: @user.email, password: "Failed"

        session[:user_id].should be_nil
      end

      it "Redirect to login_url" do
        post :create, email: @user.email, password: "Failed"

        response.should redirect_to login_url
      end

      it "Alert 'Invalid user/password combination'" do
        post :create, email: @user.email, password: "Failed"

        flash[:alert].should eq "Invalid user/password combination"
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) {
      post :create, email: users(:one).email, password: "password1"
    }

    it "session[:user_id] id nil" do
      session[:user_id].should_not be_nil

      delete :destroy

      session[:user_id].should be_nil
    end

    it "Redirect to user" do
      delete :destroy

      response.should redirect_to '/'
    end
  end
end
