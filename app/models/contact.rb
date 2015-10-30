class Contact < ActiveRecord::Base

  belongs_to :user
  has_many :phones

  NAME_FORMAT = /\A([a-z ])+\z/i
  validates :name,
    presence: true,
    :format => NAME_FORMAT,
    length: { minimum: 2, maximum: 20 }

end
