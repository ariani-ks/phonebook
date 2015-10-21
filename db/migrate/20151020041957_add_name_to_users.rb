class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string #add column name ke tabel users
  end
end
