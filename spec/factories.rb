FactoryGirl.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password "password"
    password_confirmation "password"
    admin false
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    email { Faker::Internet.email('admin') }
    name { Faker::Name.name }
    password  { Faker::Internet.password(8) }
    admin true
  end

  factory :contact, class: Contact do
    name { Faker::Name.name }
    # user_id 1
    user
  end

  factory :invalid_contact, parent: :contact do
    name nil
  end

  factory :phone do
    phone_title "Home"
    phone_number "0318281830"
    # contact_id 1
    contact
  end

  factory :invalid_phone, parent: :phone do
    phone_title nil
    phone_number nil
  end

end
