class RemoveDescriptionSchoolFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :description, :string
    remove_column :courses, :school, :string
  end
end
