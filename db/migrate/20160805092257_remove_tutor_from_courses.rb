class RemoveTutorFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_reference :courses, :tutor, foreign_key: true
  end
end
