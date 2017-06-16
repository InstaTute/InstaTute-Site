class AddRateLockToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rate_lock, :boolean
  end
end
