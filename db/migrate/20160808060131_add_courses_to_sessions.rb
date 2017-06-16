class AddCoursesToSessions < ActiveRecord::Migration[5.0]
  def change
    add_reference :sessions, :course, foreign_key: true
  end
end
