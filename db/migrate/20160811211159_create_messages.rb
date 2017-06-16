class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :chatroom, foreign_key: true
      t.references :messageable, polymorphic: true
      t.text :content

      t.timestamps
    end
  end
end
