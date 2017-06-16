class RemoveLastTutorIdFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :last_tutor_id, :integer
  end
end
