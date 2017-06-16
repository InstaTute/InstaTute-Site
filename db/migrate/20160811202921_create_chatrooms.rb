class CreateChatrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chatrooms do |t|
      t.references :user, index: true, unique: true,  foreign_key: true
      t.references :tutor, index: true, unique: true, foreign_key: true
      t.references :course, foreign_key: true
      t.text :topic
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
