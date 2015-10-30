class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :contact, index: true, foreign_key: true #references ke model contact
      t.string :phone_title
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
