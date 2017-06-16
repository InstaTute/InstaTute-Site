class AddStartFinishToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :start, :datetime
    add_column :sessions, :finish, :datetime
  end
end
