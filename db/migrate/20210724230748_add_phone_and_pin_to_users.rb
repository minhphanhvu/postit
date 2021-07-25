class AddPhoneAndPinToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :pin, :string
  end
end
