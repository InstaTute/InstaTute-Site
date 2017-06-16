class AddRatingToTutors < ActiveRecord::Migration[5.0]
  def change
    add_column :tutors, :rating, :int
  end
end
