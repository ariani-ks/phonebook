require 'rails_helper'

describe "Adding phones number" do
  let!(:contact) { Contact.create(name: "Nana", user_id: 1) }
  let!(:user) { FactoryGirl.create(:user) }

  def add_phone(options={})
    login_as(user)
    options[:phone_title] ||= "Home"
    options[:phone_number] ||= "0318281867"

    visit root_path
    click_link "Contacts"
    expect(page).to have_content("List Contacts")

    within "#contact_#{contact.id}" do
      click_link "Add Phone Number"
    end

    within('#phone-modal') do
      expect(page).to have_content("New Phone Number")
    end

    fill_in "Phone title", with: options[:phone_title]
    fill_in "Phone number", with: options[:phone_number]
    click_button "Create Phone"
  end

  it "is successful with valid content", js: true do
    add_phone phone_title: "Home", phone_number: "0318281830"

    within "#phone_table_#{contact.id}" do
      expect(page).to have_content("Home")
      expect(page).to have_content("0318281830")
    end
    # page.find("#contact_#{contact.id}").click
  end

  it "displays an error with no content", js: true do
    expect(Phone.count).to eq(0)
    add_phone phone_title: "", phone_number: ""

    expect(page).to have_content("error")
    expect(Phone.count).to eq(0)
  end

  it "displays an error when the phone has a title less than 2 characters", js: true do
    expect(Phone.count).to eq(0)
    add_phone phone_title: "A"

    expect(page).to have_content("error")
    expect(Phone.count).to eq(0)
  end

  it "displays an error when the phone has a number less than 2 characters", js: true do
    expect(Phone.count).to eq(0)
    add_phone phone_number: "8"

    expect(page).to have_content("error")
    expect(Phone.count).to eq(0)
  end

end
