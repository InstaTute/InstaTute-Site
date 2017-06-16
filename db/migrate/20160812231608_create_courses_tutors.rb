class CreateCoursesTutors < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_tutors do |t|
      t.references :course, foreign_key: true
      t.references :tutor, foreign_key: true
    end
  end
end
