class AddFinishedToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :finished, :boolean, :default => false
  end
end
