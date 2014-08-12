require 'rails_helper'

describe OrdersController do
  fixtures :all

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

  describe "POST 'create'" do
    it "the number of orders is 2 before create" do
      expect(Order.count).to eq 2
    end

    context "when successfully created" do
      before(:each) {
        @user = User.find_by_email(session[:user_id])
        session[:laptop_id] = laptops(:one)
        user_full_name = "#{@user.first_name} #{@user.last_name}"

        post :create, order: {full_name: user_full_name, 
                              email: @user.email, 
                              laptop_serial_number: session[:laptop_id].serial_number}
      }

      it "Automatically laptop_id and user_id creted" do
        expect(Order.last.laptop_id).to eq laptops(:one).id
        expect(Order.last.user_id).to eq @user.id
      end

      it "Change laptops(:one) status to RESERVED" do
        expect(laptops(:one).state).to eq "RESERVED"
      end

      it "Change user rent status to Request" do
        expect(@user.current_borrowed_laptop).to eq "REQUEST"
        expect(@user.current_borrowed_date).to eq "REQUEST"
      end

      it "Redirect to order" do
        expect(response).to redirect_to assigns(:order)
      end

      it "Flash notice message is 'was successfully ordered.' when Redirect to" do
        expect(flash[:notice]).to include "Successfully ordered."
      end

      it "Total number of orders is 3 after created" do
        expect(Order.count).to eq 3
      end
    end

    it "render new page, when failed to create" do
      session[:laptop_id] = laptops(:one)

      post :create, order: {full_name: nil}

      expect(response).to render_template "new"
    end
  end

  describe "POST 'update'" do
    it "orders(:one).order_status is nil before order state update" do
      expect(orders(:one).order_status).to eq "PROCESSING"
    end

    context "when successfully order state updated" do
      before(:each) do
        post :update, id: orders(:one).id, order: {order_status: "CONFIRMED"}
        orders(:one).reload
      end

      it "orders(:one).order_status is CONFIRMED" do
        expect(orders(:one).order_status).to eq "CONFIRMED"
      end

      it "Redirect to order" do
        expect(response).to redirect_to assigns(:order)
      end

      it "Flash notice message is 'Order was successfully updated.' when Redirect to" do
        expect(flash[:notice]).to include "was successfully updated."
      end
    end

    it "render edit page when failed to updated" do
      post :update, id: orders(:one).id, order: {full_name: nil}

      expect(response).to render_template "edit"
    end
  end

  describe "DELETE 'destroy'" do
    it "The number of orders is 2 before destroy" do
      expect(Order.count).to eq 2
    end

    context "when successfully order state deleted" do
      before(:each) {
        @laptop = Laptop.find(orders(:one).laptop_id)
        @user = User.find(orders(:one).user_id)
        delete :destroy, id: orders(:one).id
      }

      it "Delete Order(:one)" do
        expect(Order.count).to eq 1
      end

      it "Changed laptop status" do
        expect(@laptop.state).to eq "STOCKS"
      end

      it "Change user rent status to Request" do
        expect(@user.current_borrowed_laptop).to eq "Not Yet"
        expect(@user.current_borrowed_date).to eq "N/A"
      end

      it "Redirect to user" do
        expect(response).to redirect_to orders_url
      end
    end
  end
end
