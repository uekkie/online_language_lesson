# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_04_112415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_billings_on_user_id"
  end

  create_table "coupon_balances", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "number", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "expire_at", default: "2120-05-04 11:36:21", null: false
    t.boolean "period", default: false, null: false
    t.bigint "subscription_id"
    t.index ["subscription_id"], name: "index_coupon_balances_on_subscription_id"
    t.index ["user_id"], name: "index_coupon_balances_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "teacher_id", null: false
    t.index ["teacher_id", "name"], name: "index_languages_on_teacher_id_and_name", unique: true
    t.index ["teacher_id"], name: "index_languages_on_teacher_id"
  end

  create_table "lesson_feedbacks", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id", "user_id"], name: "index_lesson_feedbacks_on_lesson_id_and_user_id", unique: true
    t.index ["lesson_id"], name: "index_lesson_feedbacks_on_lesson_id"
    t.index ["user_id"], name: "index_lesson_feedbacks_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "language_id", null: false
    t.string "zoom_url", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date", null: false
    t.integer "hour", default: 7, null: false
    t.index ["language_id"], name: "index_lessons_on_language_id"
    t.index ["teacher_id"], name: "index_lessons_on_teacher_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_reports_on_lesson_id"
    t.index ["user_id", "lesson_id"], name: "index_reports_on_user_id_and_lesson_id", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_reservations_on_lesson_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "plan_id", null: false
    t.boolean "suspend", default: false, null: false
    t.datetime "start_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.text "introduce", default: "", null: false
    t.string "avatar", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "stripe_customer_id", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "done_trial", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "billings", "users"
  add_foreign_key "coupon_balances", "subscriptions"
  add_foreign_key "coupon_balances", "users"
  add_foreign_key "languages", "teachers"
  add_foreign_key "lesson_feedbacks", "lessons"
  add_foreign_key "lesson_feedbacks", "users"
  add_foreign_key "lessons", "languages"
  add_foreign_key "lessons", "teachers"
  add_foreign_key "reports", "lessons"
  add_foreign_key "reports", "users"
  add_foreign_key "reservations", "lessons"
  add_foreign_key "reservations", "users"
  add_foreign_key "subscriptions", "users"
end
