require 'rails_helper'

# http://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html

RSpec.describe ContactsController, :type => :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    @contact = Contact.create(name: "Nana", user_id: @user.id)
  end

  describe "GET index" do
    it "assigns @contacts" do
      # contact = Contact.create(name: "Nana", user_id: 1)
      get :index
      expect(assigns(:contacts)).to eq([@contact])
      # expect(assigns(:contacts)).to eq([contact])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new contact" do
        # expect{
        #   post :create, contact: FactoryGirl.attributes_for(:contact)
        # }.to change(Contact,:count).by(1)
        xhr :post, :create, contact: FactoryGirl.attributes_for(:contact)
        # xhr :post, :create, contact: { name: "Lala" }  #bisa
        expect(Contact.count).to eq(2)
        response.code.should == "200"
      end

      it "redirects to the new contact" do
        xhr :post, :create, contact: FactoryGirl.attributes_for(:contact)
        response.should render_template :create
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact" do
        xhr :post, :create, contact: FactoryGirl.attributes_for(:invalid_contact)
        expect(Contact.count).to eq(1)
      end

      it "re-renders the new method" do
        xhr :post, :create, contact: FactoryGirl.attributes_for(:invalid_contact)
        response.should render_template :create
      end
    end
  end

  describe 'PUT update' do
    context "valid attributes" do
      it "located the requested @contact" do
        xhr :post, :update, id: @contact, contact: FactoryGirl.attributes_for(:contact)
        assigns(:contact).should eq(@contact) #??
      end

      it "changes @contact's attributes" do
        xhr :post, :update, id: @contact, contact: FactoryGirl.attributes_for(:contact, name: "Lala", user_id: 1)
        @contact.reload
        @contact.name.should eq("Lala")
        @contact.user_id.should eq(1)
      end

      it "redirects to the updated contact" do
        xhr :post, :update, id: @contact, contact: FactoryGirl.attributes_for(:contact)
        response.code.should == "200"
      end
    end

    context "invalid attributes" do
      it "locates the requested @contact" do
        xhr :post, :update, id: @contact, contact: FactoryGirl.attributes_for(:invalid_contact)
        assigns(:contact).should eq(@contact)
      end

      it "does not change @contact's attributes" do
        xhr :post, :update, id: @contact, contact: FactoryGirl.attributes_for(:contact, name: nil, user_id: 1)
        @contact.reload
        @contact.name.should eq("Nana")
      end

      it "re-renders the edit method" do
        xhr :post, :update, id: @contact, contact: FactoryGirl.attributes_for(:invalid_contact)
        response.should render_template :update
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the contact" do
      xhr :delete, :destroy, id: @contact
      expect(Contact.count).to eq(0)
    end

    it "redirects to contacts#index" do
      xhr :delete, :destroy, id: @contact
      response.should render_template :destroy
    end
  end

end
