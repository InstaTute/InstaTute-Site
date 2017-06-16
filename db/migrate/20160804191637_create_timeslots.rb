class CreateTimeslots < ActiveRecord::Migration[5.0]
  def change
    create_table :timeslots do |t|
      t.datetime :start
      t.datetime :end
      t.references :tutor, foreign_key: true

      t.timestamps
    end
  end
end
