require 'rails_helper'

describe LaptopsController do
  extend AuthHelpers
  fixtures :laptops
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
    it "Assigns the requested laptop to laptops(:one)" do
      get :show, id: laptops(:one).id
      expect(assigns(:laptop)).to eq laptops(:one)
    end
  end

  describe "POST 'create'" do
    context "when successfully created" do
      before(:each) {
        post :create, laptop: {serial_number: "9876", model_: "MacPro", hdd_size: "50GB", cpu_speed: 'Fast',  ram: 'Big',  screen_size: '55"', purchased_date: "2014-05-06"}
      }

      it "Responds redirect to laptop when successfully created" do
        expect(response).to redirect_to assigns(:laptop)
      end

      it "Flash Notice message is 'Laptop was successfully created.'" do
        expect(flash[:notice]).to eq "Laptop was successfully created."
      end
    end

    it "Responds render new when failed to create" do
      post :create, laptop: {serial_number: "9876", purchased_date: "2014-05-06"}
      expect(response).to render_template("new")
    end
  end

  describe "POST 'update'" do
    it "Before updated laptops(:one) serial_number to 1234" do
        expect(laptops(:one).serial_number).to eq "1234"
    end
    
    context "when successfully updated" do
      before(:each) {
        post :update, id: laptops(:one).id, laptop: {serial_number: "4321"}
        laptops(:one).reload
      }

      it "Updated laptops(:one) serial_number to 1346" do
        expect(laptops(:one).serial_number).to eq "4321"
      end

      it "Responds redirect to laptop" do
        expect(response).to redirect_to assigns(:laptop)
      end

      it "Flash Notice message is 'Laptop was successfully updated.'" do
        expect(flash[:notice]).to eq "Laptop was successfully updated."
      end
    end

    it "Responds render new when failed to update" do
      post :update, id: laptops(:one).id, laptop: {serial_number: nil}
      expect(response).to render_template("edit")
    end
  end

  describe "DELETE 'destroy'" do
    it "Delete laptop(:one)" do
      expect {delete :destroy, id: laptops(:one).id}.to change(Laptop,:count).by(-1)
    end

    it "Responds redirect to laptops_url" do
      delete :destroy, id: laptops(:one).id
      expect(response).to redirect_to laptops_url
    end
  end
end
