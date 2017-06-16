class Notification < ApplicationRecord
  belongs_to :tutor
  belongs_to :chatroom
end
