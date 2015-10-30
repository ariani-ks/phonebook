require 'rails_helper'

describe "Creating contacts" do
  # let!(:phone) { Phone.create(phone_title: "kantor", phone_number: "0318281830") }
  let!(:user) { FactoryGirl.create(:user) }

  def create_contact(options={})
    options[:name] ||= "Test"

    visit root_path
    click_link "Contacts"
    expect(page).to have_content("List Contacts")

    click_link "Add New"

    within('#contact-modal') do
      expect(page).to have_content("New Contact")
    end

    fill_in "Name", with: options[:name]
    click_button "Submit"

    # find('link', :text => 'Add New').click
    # page.find("#btnAddNew").click
  end

  it "redirects to the contact list index page on success", js: true do #js true utk test mgunakan selenium
    # user = FactoryGirl.create(:user)
    login_as(user)
    # login
    create_contact
    expect(page).to have_content("Test")
  end

  it "displays an error when the contact has no name", js: true do
    # user = FactoryGirl.create(:user)
    login_as(user)

    expect(Contact.count).to eq(0)
    create_contact name: ""

    expect(page).to have_content("error")
    expect(Contact.count).to eq(0)
  end

  it "displays an error when the contact has a name less than 2 characters", js: true do
    # user = FactoryGirl.create(:user)
    login_as(user)

    expect(Contact.count).to eq(0)
    create_contact name: "A"

    expect(page).to have_content("error")
    expect(Contact.count).to eq(0)

    # visit contacts_path
    # expect(page).to_not have_content("A")
  end

end
