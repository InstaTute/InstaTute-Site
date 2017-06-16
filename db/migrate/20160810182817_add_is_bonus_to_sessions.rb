class AddIsBonusToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :is_bonus, :boolean
  end
end
