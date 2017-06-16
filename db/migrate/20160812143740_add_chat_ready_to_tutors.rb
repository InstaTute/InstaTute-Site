class AddChatReadyToTutors < ActiveRecord::Migration[5.0]
  def change
    add_column :tutors, :chat_ready, :boolean
  end
end
