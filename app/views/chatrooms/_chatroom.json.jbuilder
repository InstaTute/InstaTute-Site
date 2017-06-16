json.extract! chatroom, :id, :user_id, :tutor_id, :course_id, :topic, :start, :finish, :created_at, :updated_at
json.url chatroom_url(chatroom, format: :json)