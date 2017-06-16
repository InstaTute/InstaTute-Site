class CreateTutorsCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :tutors_courses do |t|
      t.references :tutor, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
