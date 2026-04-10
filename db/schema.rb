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

ActiveRecord::Schema[8.1].define(version: 2026_04_10_152804) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "adoptions", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.date "applied_on"
    t.datetime "created_at", null: false
    t.text "notes"
    t.bigint "person_id", null: false
    t.text "questionnaire_answers"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_adoptions_on_animal_id"
    t.index ["person_id"], name: "index_adoptions_on_person_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "approximate_age"
    t.string "breed"
    t.string "color"
    t.datetime "created_at", null: false
    t.boolean "dewormed"
    t.integer "gender"
    t.string "name"
    t.boolean "neutered"
    t.text "notes"
    t.integer "size"
    t.integer "species"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.boolean "vaccinated"
    t.decimal "weight"
  end

  create_table "foster_cares", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.datetime "created_at", null: false
    t.date "end_date"
    t.text "notes"
    t.bigint "person_id", null: false
    t.date "start_date"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_foster_cares_on_animal_id"
    t.index ["person_id"], name: "index_foster_cares_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.string "relationship_type"
    t.string "rg"
    t.string "state"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "activity_type"
    t.string "availability"
    t.datetime "created_at", null: false
    t.boolean "image_use_authorized"
    t.bigint "person_id", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_volunteers_on_person_id"
  end

  add_foreign_key "adoptions", "animals"
  add_foreign_key "adoptions", "people"
  add_foreign_key "foster_cares", "animals"
  add_foreign_key "foster_cares", "people"
  add_foreign_key "volunteers", "people"
end
