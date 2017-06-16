class CreateUsersCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :users_courses do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
