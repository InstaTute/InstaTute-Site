class AddTutorToSessions < ActiveRecord::Migration[5.0]
  def change
    add_reference :sessions, :tutor, foreign_key: true
  end
end
