require 'rails_helper'

describe "Creating phone lists" do
  def create_phone_list(options={})
    options[:phone_title] ||= "Home"
    options[:phone_number] ||= "0318281835"

    visit "/phones"
    click_link "Add New"
    expect(page).to have_content("New Phone Number")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end
end
