require 'rails_helper'

describe SessionsController do
  fixtures :users

  before(:each) {
    @user = users(:one)
  }

  describe "POST 'create'" do
    it "Session[:user_id] is not user email before login" do
      expect(session[:user_id]).not_to eq @user.email
    end

    context "when successfully login" do
      it "user email equals session[:user_id]" do
        post :create, email: @user.email, password: "password1"

        expect(@user.email).to eq session[:user_id]
      end

      it "Redirect to order" do
        post :create, email: @user.email, password: "password1"

        expect(response).to redirect_to '/'
      end
    end

    context "when failed to login" do
      it "session[:user_id] is nil" do
        post :create, email: @user.email, password: "Failed"

        expect(session[:user_id]).to be_nil
      end

      it "Redirect to login_url" do
        post :create, email: @user.email, password: "Failed"

        expect(response).to redirect_to login_url
      end

      it "Alert 'Invalid user/password combination'" do
        post :create, email: @user.email, password: "Failed"

        expect(flash[:alert]).to eq "Invalid user/password combination"
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) {
      post :create, email: @user.email, password: "password1"
    }

    it "Session[:user_id] is user email before logout" do
      expect(session[:user_id]).not_to be_nil
      expect(session[:user_id]).to eq @user.email
    end

    context "when successfully logout" do
      it "session[:user_id] id nil" do
        delete :destroy

        expect(session[:user_id]).to be_nil
        expect(session[:user_id]).not_to eq @user.email
      end

      it "Redirect to user" do
        delete :destroy

        expect(response).to redirect_to '/'
      end
    end
  end
end
