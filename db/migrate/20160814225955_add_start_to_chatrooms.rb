class AddStartToChatrooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chatrooms, :start, :datetime
  end
end
