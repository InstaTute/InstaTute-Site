class AddSessionCountToTutor < ActiveRecord::Migration[5.0]
  def change
    add_column :tutors, :session_count, :int
  end
end
