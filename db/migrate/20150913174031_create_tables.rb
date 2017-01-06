class CreateTables < ActiveRecord::Migration
  def change
  create_table "approved_accounts", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "certificates", force: :cascade do |t|
    t.string   "number"
    t.datetime "expiration_date"
    t.string   "cert_type"
    t.boolean  "approved"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "front_file_name"
    t.string   "front_content_type"
    t.integer  "front_file_size"
    t.datetime "front_updated_at"
    t.string   "back_file_name"
    t.string   "back_content_type"
    t.integer  "back_file_size"
    t.datetime "back_updated_at"
  end

  create_table "join_requests", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "student_id"
    t.string   "email"
    t.string   "grad_year"
    t.string   "major"
    t.string   "career_goal"
    t.string   "cert_source"
    t.string   "emt_number"
    t.string   "emt_exp_date"
    t.string   "cpr_exp_date"
    t.string   "nremt_number"
    t.string   "other_certs"
    t.boolean  "none"
    t.boolean  "ma_ambulance"
    t.boolean  "ma_fire"
    t.boolean  "fire_ambulance"
    t.string   "other_experience"
    t.string   "other_info"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "approved"
  end

  create_table "one_user_shifts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts", force: :cascade do |t|
    t.string   "venue_name"
    t.string   "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "shift_time"
  end

  create_table "static_contents", force: :cascade do |t|
    t.string   "sc_key"
    t.string   "sc_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "two_user_shifts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "mass_number"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "role"
    t.string   "hold"
    t.string   "status"
    t.string   "bio"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "venue", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vol_user_shifts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shift_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  end
end
