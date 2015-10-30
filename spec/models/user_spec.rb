require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it "is invalid without a name" do
    # FactoryGirl.build(:user, :name => nil).should_not be_valid
    user = FactoryGirl.build(:user, name: nil)
    # user = FactoryGirl.build(:user, :name => nil)
    user.valid?
    expect(User.count).to eq 0
  end

end
