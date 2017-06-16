class AddFirstNameToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :first_name, :string
  end
end
