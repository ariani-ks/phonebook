class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :user, index: true, foreign_key: true #references ke model user
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
