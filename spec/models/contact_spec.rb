require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "is valid with a name, user id" do
    contact = Contact.new(
      name: 'Nana',
      user_id: 1
    )
    expect(contact).to be_valid
  end

  it "is invalid without a name" do
    contact = Contact.new(name: nil)
    contact.valid?
    expect(contact.errors[:name]).to include("can't be blank")
  end
end
