class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :messageable, polymorphic: true

  def attachable_type=(class_name)
     super(class_name.constantize.base_class.to_s)
  end
end
