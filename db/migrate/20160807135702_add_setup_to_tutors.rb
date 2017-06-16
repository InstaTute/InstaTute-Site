class AddSetupToTutors < ActiveRecord::Migration[5.0]
  def change
    add_column :tutors, :setup, :boolean
  end
end
