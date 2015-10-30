require 'rails_helper'

describe "Editing phones number" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:contact) { Contact.create(name: "Nana", user_id: 1) }
  let!(:phone) { Phone.create(phone_title: "Home", phone_number: "0318281867", contact_id: 1) }

  def update_phone(options={})
    login_as(user)
    options[:phone_title] ||= "Home"
    options[:phone_number] ||= "0318281867"

    visit root_path
    click_link "Contacts"
    expect(page).to have_content("List Contacts")

    page.find("#contact_#{contact.id}").click
    within "#phone_#{phone.id}" do
      click_link "Edit"
    end

    within('#phone-modal') do
      expect(page).to have_content("Edit Phone Number")
    end

    fill_in "Phone title", with: options[:phone_title]
    fill_in "Phone number", with: options[:phone_number]
    # byebug
    click_button "Update Phone"
  end

  it "is successful with valid content", js: true do
    update_phone phone_title: "Office", phone_number: "0318281830"

    # byebug
    visit contacts_path
    phone.reload
    expect(phone.phone_title).to eq("Office")
    expect(phone.phone_number).to eq("0318281830")
  end

  it "displays an error with no title", js: true do
    update_phone phone_title: ""
    title = phone.phone_title
    phone.reload
    expect(phone.phone_title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error with title less than 2 characters", js: true do
    update_phone phone_title: "A"
    title = phone.phone_title
    phone.reload
    expect(phone.phone_title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error with no number", js: true do
    update_phone phone_number: ""
    number = phone.phone_number
    phone.reload
    expect(phone.phone_number).to eq(number)
    expect(page).to have_content("error")
  end

  it "displays an error with number less than 2 characters", js: true do
    update_phone phone_number: "5"
    number = phone.phone_number
    phone.reload
    expect(phone.phone_number).to eq(number)
    expect(page).to have_content("error")
  end
end
