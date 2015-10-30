require 'rails_helper'

RSpec.describe Phone, type: :model do
  it "does not allow duplicate phone numbers per contact" do
    contact = Contact.create(
      name: 'Nana',
      user_id: 1
    )
    contact.phones.create(
      phone_title: 'Home',
      phone_number: '0318281830',
      contact_id: contact.id
    )
    mobile_phone = contact.phones.new(
      phone_title: "Home",
      phone_number: "0318281830",
      contact_id: contact.id
    )

    mobile_phone.valid?
    expect(mobile_phone.errors[:phone_number]).to include('has already been taken')
  end

  it "is valid with a phone title, phone number" do
    phone = Phone.new(
      phone_title: "Home",
      phone_number: "0318281830"
    )
    expect(phone).to be_valid
  end

  it "is invalid without a phone title" do
    phone = Phone.new(phone_title: nil)
    phone.valid?
    expect(phone.errors[:phone_title]).to include("can't be blank")
  end

  it "is invalid without a phone number" do
    phone = Phone.new(phone_number: nil)
    phone.valid?
    expect(phone.errors[:phone_number]).to include("can't be blank")
  end

end
