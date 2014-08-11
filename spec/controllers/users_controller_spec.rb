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
    it "Responds successfully with an HTTP 200 status code" do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET 'show'" do
    it "Assigns the requested laptop to users(:one)" do
      get :show, id: users(:one).id

      expect(assigns(:user)).to eq users(:one)
    end
  end

  describe "POST 'create'" do
    it "the number of users is 3 before create" do
      expect(User.count).to eq 3
    end

    context "when successfully created" do
      before(:each) {
        post :create, user: {first_name: "Sara", last_name: "Mong", email: "sara2@example.com", password: "password3", password_confirmation: "password3", department: "Software"}
      }

      it "Automatically current_borrowed state updated" do
        expect(User.last.current_borrowed_laptop).to eq "Not Yet"
        expect(User.last.current_borrowed_date).to eq "N/A"
      end

      it "Redirect to user" do
        expect(response).to redirect_to assigns(:user)
      end

      it "Flash notice message is 'Laptop was successfully created.' when Redirect to" do
        expect(flash[:notice]).to include "was successfully created."
      end

      it "Total number of users is 4 after created" do
        expect(User.count).to eq 4
      end
    end

    it "render new page, when failed to create" do
      post :create, user: {first_name: "Sara"}

      expect(response).to render_template "new"
    end
  end

  describe "POST 'update'" do
    it "users(:one).first_name is John before update" do
      expect(users(:one).first_name).to eq "John"
    end

    context "when successfully updated" do
      before(:each) {
        post :update, id: users(:one).id, user: {first_name: "Mike"}
        users(:one).reload
      }

      it "users(:one).first_name changed to Mike" do
        expect(users(:one).first_name).to eq "Mike"
      end

      it "Redirect to user page" do
        expect(response).to redirect_to assigns(:user)
      end

      it "Flash notice message is 'Laptop was successfully created.' when Redirect to" do
        expect(flash[:notice]).to include "was successfully updated."
      end
    end

    it "render edit page when failed to updated" do
      post :update, id: users(:one).id, user: {first_name: nil}

      expect(response).to render_template "edit"
    end
  end

  describe "Delete 'destroy'" do
    it "Delete users(:one)" do
      expect {delete :destroy, id: users(:one).id}.to change(User,:count).by(-1)
    end

    it "Redirect to user" do
      delete :destroy, id: users(:one).id

      expect(response).to redirect_to "/"
    end
  end
end
