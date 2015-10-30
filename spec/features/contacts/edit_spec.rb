require 'rails_helper'

describe "Editing contacts" do
  let!(:contact) { Contact.create(name: "Nana", user_id: 1) }
  let!(:user) { FactoryGirl.create(:user) }

  def update_contact(options={})
    login_as(user)
    options[:name] ||= "New name"
    # contact = options[:contact]

    visit root_path
    click_link "Contacts"
    expect(page).to have_content("List Contacts")

    within "#contact_#{contact.id}" do
      click_link "Edit"
    end

    within('#contact-modal') do
      expect(page).to have_content("Edit Contact")
    end

    fill_in "Name", with: options[:name]
    click_button "Submit"
  end

  it "updates a contact successfully with correct information", js: true do
    update_contact name: "New name"
    contact.reload

    # expect(page).to have_content("Contact was successfully updated")
    expect(contact.name).to eq("New name")
  end

  it "displays an error with no name", js: true do
    update_contact name: ""
    name = contact.name
    contact.reload
    expect(contact.name).to eq(name)
    expect(page).to have_content("error")
  end

  it "displays an error with name less than 2 characters", js: true do
    # update_contact contact: contact, name: "A"
    update_contact name: "A"

    expect(page).to have_content("error")
  end
end
