# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_21_180811) do
  create_table "applications", force: :cascade do |t|
    t.integer "section_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_applications_on_section_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "term"
    t.string "title"
    t.string "description"
    t.string "subject"
    t.integer "catalog_number"
    t.string "campus"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses_student_applications", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "student_application_id", null: false
  end

  create_table "grading_assignments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_grading_assignments_on_section_id"
    t.index ["user_id"], name: "index_grading_assignments_on_user_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "student_email"
    t.string "prof_email"
    t.integer "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id", null: false
    t.text "reason"
    t.index ["course_id"], name: "index_recommendations_on_course_id"
    t.index ["section_id"], name: "index_recommendations_on_section_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer "section_number"
    t.string "component"
    t.string "instruction_mode"
    t.string "building_description"
    t.string "start_time"
    t.string "end_time"
    t.string "start_date"
    t.string "end_date"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "required_graders"
  end

  create_table "student_applications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "status", default: "pending", null: false
    t.text "preferences_in_grading_assignments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_info"
    t.integer "course_id"
    t.index ["course_id"], name: "index_student_applications_on_course_id"
    t.index ["status"], name: "index_student_applications_on_status"
    t.index ["user_id"], name: "index_student_applications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified"
    t.json "availability"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "applications", "sections"
  add_foreign_key "applications", "users"
  add_foreign_key "grading_assignments", "sections"
  add_foreign_key "grading_assignments", "users"
  add_foreign_key "recommendations", "courses"
  add_foreign_key "recommendations", "sections"
  add_foreign_key "student_applications", "courses"
  add_foreign_key "student_applications", "users"
end
