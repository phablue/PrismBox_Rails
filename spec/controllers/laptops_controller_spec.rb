require "spec_helper"

describe LaptopsController do
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
      expect(response.status).to eq 200
    end
  end

  describe "GET 'show'" do
    it "Assigns the requested laptop to laptops(:one)" do
      get :show, id: laptops(:one).id
      assigns(:laptop).should eq laptops(:one)
    end
  end

  describe "POST 'create'" do
    before(:each) {
      post :create, laptop: {serial_number: "9876", model_: "MacPro", hdd_size: "50GB", cpu_speed: 'Fast',  ram: 'Big',  screen_size: '55"', purchased_date: "2014-05-06"}
    }

    it "Responds redirect to laptop" do
      response.should redirect_to assigns(:laptop)
    end

    it "Flash Notice message is 'Laptop was successfully created.'" do
      flash[:notice].should eq "Laptop was successfully created."
    end
  end

  describe "POST 'update'" do
    before(:each) {
      laptops(:one).serial_number.should eq "1234"
      post :update, id: laptops(:one).id, laptop: {serial_number: "4321"}
      laptops(:one).reload
    }

    it "Updated laptops(:one) serial_number to 1346" do
      laptops(:one).serial_number.should eq "4321"
    end

    it "Responds redirect to laptop" do
      response.should redirect_to assigns(:laptop)
    end

    it "Flash Notice message is 'Laptop was successfully updated.'" do
      flash[:notice].should eq "Laptop was successfully updated."
    end
  end

  describe "DELETE 'destroy'" do
    it "Delete laptop(:one)" do
      expect {delete :destroy, id: laptops(:one).id}.to change(Laptop,:count).by(-1)
    end

    it "Responds redirect to laptops_url" do
      delete :destroy, id: laptops(:one).id
      response.should redirect_to laptops_url
    end
  end
end
