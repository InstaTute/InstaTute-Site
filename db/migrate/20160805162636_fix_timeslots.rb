class FixTimeslots < ActiveRecord::Migration[5.0]
  def up
    remove_column :timeslots, :start
    remove_column :timeslots, :end
    add_column :timeslots, :slot_start, :datetime
    add_column :timeslots, :slot_finish, :datetime
  end
  def down
    add_column :timeslots, :start, :datetime
    add_column :timeslots, :end, :datetime
    remove_column :timeslots, :slot_start
    remove_column :timeslots, :slot_finish
  end
end
