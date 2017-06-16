class AddSubjectToCourses < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses, :subject, foreign_key: true
  end
end
