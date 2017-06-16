class AddLengthToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :length, :int
  end
end
