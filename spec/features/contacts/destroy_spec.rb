require 'rails_helper'

describe "Deleting contacts" do
  let!(:contact) { Contact.create(name: "Nana", user_id: 1) }
  let!(:user) { FactoryGirl.create(:user) }

  it "is successful when clicking the destroy link", js: true do
    login_as(user)
    visit root_path
    click_link "Contacts"
    expect(page).to have_content("List Contacts")

    within "#contact_#{contact.id}" do
      click_link "Delete"
    end

    click_link "Yes"
    expect(page).to_not have_content(contact.name)
    expect(Contact.count).to eq(0)
  end
end
