class Phone < ActiveRecord::Base
  belongs_to :user
  validates :phone_title, presence: true,
                      length: { minimum: 2, maximum: 30 }

  validates :phone_number, presence: true,
                      length: { minimum: 2, maximum: 15 }
end
