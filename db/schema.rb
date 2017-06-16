# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160825213547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "admins", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "bonus_sessions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatrooms", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "tutor_id"
    t.uuid     "course_id"
    t.text     "topic"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "start"
    t.boolean  "finished",   default: false
    t.index ["course_id"], name: "index_chatrooms_on_course_id", using: :btree
    t.index ["tutor_id"], name: "index_chatrooms_on_tutor_id", using: :btree
    t.index ["user_id"], name: "index_chatrooms_on_user_id", using: :btree
  end

  create_table "courses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "subject_id"
    t.index ["subject_id"], name: "index_courses_on_subject_id", using: :btree
  end

  create_table "courses_tutors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "course_id"
    t.uuid "tutor_id"
    t.index ["course_id"], name: "index_courses_tutors_on_course_id", using: :btree
    t.index ["tutor_id"], name: "index_courses_tutors_on_tutor_id", using: :btree
  end

  create_table "courses_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "course_id"
    t.uuid "user_id"
    t.index ["course_id"], name: "index_courses_users_on_course_id", using: :btree
    t.index ["user_id"], name: "index_courses_users_on_user_id", using: :btree
  end

  create_table "messages", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "chatroom_id"
    t.string   "messageable_type"
    t.uuid     "messageable_id"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "first_name"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id", using: :btree
  end

  create_table "notifications", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "tutor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.uuid     "chatroom_id"
    t.index ["chatroom_id"], name: "index_notifications_on_chatroom_id", using: :btree
    t.index ["tutor_id"], name: "index_notifications_on_tutor_id", using: :btree
  end

  create_table "sessions", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_id"
    t.uuid     "tutor_id"
    t.datetime "start"
    t.datetime "finish"
    t.text     "topic"
    t.uuid     "course_id"
    t.integer  "length"
    t.string   "location"
    t.boolean  "is_bonus"
    t.index ["course_id"], name: "index_sessions_on_course_id", using: :btree
    t.index ["tutor_id"], name: "index_sessions_on_tutor_id", using: :btree
    t.index ["user_id"], name: "index_sessions_on_user_id", using: :btree
  end

  create_table "subjects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timeslots", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "tutor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "slot_start"
    t.datetime "slot_finish"
    t.index ["tutor_id"], name: "index_timeslots_on_tutor_id", using: :btree
  end

  create_table "tutors", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "stripe_id"
    t.boolean  "setup"
    t.integer  "session_count"
    t.integer  "service"
    t.integer  "rating"
    t.boolean  "chat_ready"
    t.index ["email"], name: "index_tutors_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_tutors_on_reset_password_token", unique: true, using: :btree
  end

  create_table "tutors_courses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "tutor_id"
    t.uuid "course_id"
    t.index ["course_id"], name: "index_tutors_courses_on_course_id", using: :btree
    t.index ["tutor_id"], name: "index_tutors_courses_on_tutor_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "school"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "stripe_id"
    t.boolean  "rate_lock"
    t.uuid     "last_tutor_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_courses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "course_id"
    t.index ["course_id"], name: "index_users_courses_on_course_id", using: :btree
    t.index ["user_id"], name: "index_users_courses_on_user_id", using: :btree
  end

  add_foreign_key "chatrooms", "courses"
  add_foreign_key "chatrooms", "tutors"
  add_foreign_key "chatrooms", "users"
  add_foreign_key "courses", "subjects"
  add_foreign_key "courses_tutors", "courses"
  add_foreign_key "courses_tutors", "tutors"
  add_foreign_key "courses_users", "courses"
  add_foreign_key "courses_users", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "notifications", "chatrooms"
  add_foreign_key "notifications", "tutors"
  add_foreign_key "sessions", "courses"
  add_foreign_key "sessions", "tutors"
  add_foreign_key "sessions", "users"
  add_foreign_key "timeslots", "tutors"
  add_foreign_key "tutors_courses", "courses"
  add_foreign_key "tutors_courses", "tutors"
  add_foreign_key "users_courses", "courses"
  add_foreign_key "users_courses", "users"
end
