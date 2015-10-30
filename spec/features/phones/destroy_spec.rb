require 'rails_helper'

describe "Deleting phones" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:contact) { Contact.create(name: "Nana", user_id: 1) }
  let!(:phone) { Phone.create(phone_title: "Home", phone_number: "0318281867", contact_id: 1) }

  it "is successful when clicking the destroy link", js: true do
    login_as(user)
    visit root_path
    click_link "Contacts"
    expect(page).to have_content("List Contacts")

    page.find("#contact_#{contact.id}").click
    within "#phone_#{phone.id}" do
      click_link "Delete"
    end

    click_link "Yes"
    expect(Phone.count).to eq(0)
  end
end
