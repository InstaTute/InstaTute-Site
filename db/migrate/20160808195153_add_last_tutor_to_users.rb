class AddLastTutorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_tutor_id, :int
  end
end
