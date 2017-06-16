class RemoveStartFinishFromChatrooms < ActiveRecord::Migration[5.0]
  def change
    remove_column :chatrooms, :start, :datetime
    remove_column :chatrooms, :finish, :datetime
  end
end
