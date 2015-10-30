require 'rails_helper'

RSpec.describe PhonesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    # @phone = FactoryGirl.create(:phone)
    # sign_in @phone.contact.user
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new phones" do
        xhr :post, :create, phone: FactoryGirl.attributes_for(:phone)
        expect(Phone.count).to eq(1)
        response.code.should == "200"
        # byebug
      end

      it "redirects to the new phone" do
        xhr :post, :create, phone: FactoryGirl.attributes_for(:phone)
        response.should render_template :create
      end
    end

    context "with invalid attributes" do
      it "does not save the new phone" do
        xhr :post, :create, phone: FactoryGirl.attributes_for(:invalid_phone)
        expect(Phone.count).to eq(0)
      end

      it "re-renders the new method" do
        xhr :post, :create, phone: FactoryGirl.attributes_for(:invalid_phone)
        response.should render_template :create
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      @phone = FactoryGirl.create(:phone)
    end

    context "valid attributes" do
      it "located the requested @phone" do
        xhr :post, :update, id: @phone, phone: FactoryGirl.attributes_for(:phone)
        assigns(:phone).should eq(@phone) #??
      end

      it "changes @phone's attributes" do
        xhr :post, :update, id: @phone, phone: FactoryGirl.attributes_for(:phone, phone_title: "Home", phone_number: "0318281830")
        @phone.reload
        @phone.phone_title.should eq("Home")
        @phone.phone_number.should eq("0318281830")
      end

      it "redirects to the updated phone" do
        xhr :post, :update, id: @phone, phone: FactoryGirl.attributes_for(:phone)
        response.code.should == "200"
      end
    end

    context "invalid attributes" do
      it "locates the requested @phone" do
        xhr :post, :update, id: @phone, phone: FactoryGirl.attributes_for(:invalid_phone)
        assigns(:phone).should eq(@phone)
      end

      it "does not change @phone's attributes" do
        phone_title = @phone.phone_title
        phone_number = @phone.phone_number
        xhr :post, :update, id: @phone, phone: FactoryGirl.attributes_for(:phone, phone_title: nil, phone_number: nil)
        @phone.reload
        @phone.phone_title.should eq(phone_title)
        @phone.phone_number.should eq(phone_number)
      end

      it "re-renders the edit method" do
        xhr :post, :update, id: @phone, phone: FactoryGirl.attributes_for(:invalid_phone)
        response.should render_template :update
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @phone = FactoryGirl.create(:phone)
    end

    it "deletes the phone" do
      xhr :delete, :destroy, id: @phone
      expect(Phone.count).to eq(0)
    end

    it "redirects to contacts#index" do
      xhr :delete, :destroy, id: @phone
      response.should render_template :destroy
    end
  end


end
