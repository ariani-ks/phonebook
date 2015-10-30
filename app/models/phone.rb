class Phone < ActiveRecord::Base
  belongs_to :contact
  validates :phone_title, presence: true,
                      length: { minimum: 2, maximum: 30 }

  PHONE_FORMAT = /0\d{5,10}\z/

  validates :phone_number,
    presence: true,
    :format => PHONE_FORMAT,
    length: { minimum: 2, maximum: 15 },
    uniqueness: { scope: :contact_id }
end
