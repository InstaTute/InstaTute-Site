class AddTopicToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :topic, :text
  end
end
