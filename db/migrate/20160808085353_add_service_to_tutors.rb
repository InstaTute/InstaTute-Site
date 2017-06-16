class AddServiceToTutors < ActiveRecord::Migration[5.0]
  def change
    add_column :tutors, :service, :int
  end
end
