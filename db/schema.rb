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

ActiveRecord::Schema[8.1].define(version: 2026_04_13_190200) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "audit_logs", force: :cascade do |t|
    t.string "action", null: false
    t.bigint "auditable_id"
    t.string "auditable_type"
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "occurred_at", null: false
    t.string "path"
    t.jsonb "payload", default: {}
    t.string "resource_name"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["action"], name: "index_audit_logs_on_action"
    t.index ["auditable_type", "auditable_id"], name: "index_audit_logs_on_auditable_type_and_auditable_id"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "complaint_updates", force: :cascade do |t|
    t.string "author"
    t.bigint "complaint_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "status_changed_to"
    t.datetime "updated_at", null: false
    t.index ["complaint_id"], name: "index_complaint_updates_on_complaint_id"
  end

  create_table "complaints", force: :cascade do |t|
    t.bigint "animal_id"
    t.boolean "anonymous", default: false, null: false
    t.string "assigned_to"
    t.integer "category", default: 0, null: false
    t.string "complainant_name"
    t.string "complainant_phone"
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.string "location_address"
    t.string "location_city"
    t.string "location_reference"
    t.text "notes"
    t.integer "priority", default: 0, null: false
    t.string "protocol_number", null: false
    t.datetime "received_at", null: false
    t.datetime "resolved_at"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_complaints_on_animal_id"
    t.index ["protocol_number"], name: "index_complaints_on_protocol_number", unique: true
  end

  create_table "deworming_records", force: :cascade do |t|
    t.date "administered_at", null: false
    t.bigint "animal_id", null: false
    t.datetime "created_at", null: false
    t.date "next_due_at"
    t.text "notes"
    t.string "product_name", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_deworming_records_on_animal_id"
  end

  create_table "document_links", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "document_id", null: false
    t.bigint "documentable_id", null: false
    t.string "documentable_type", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_document_links_on_document_id"
    t.index ["documentable_type", "documentable_id"], name: "index_document_links_on_documentable"
  end

  create_table "document_signatures", force: :cascade do |t|
    t.boolean "accepted_terms", default: true, null: false
    t.string "content_hash"
    t.datetime "created_at", null: false
    t.bigint "document_id", null: false
    t.datetime "signed_at"
    t.string "signer_ip"
    t.string "signer_name"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["document_id"], name: "index_document_signatures_on_document_id"
    t.index ["user_id"], name: "index_document_signatures_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "category"
    t.text "content"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "document_type"
    t.datetime "generated_at"
    t.string "hash_signature"
    t.boolean "is_locked", default: false
    t.bigint "linked_id"
    t.string "linked_type"
    t.datetime "signed_at"
    t.bigint "signed_by_user_id"
    t.datetime "signer_accepted_at"
    t.string "signer_ip"
    t.string "signer_name"
    t.string "status", default: "draft"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["linked_type", "linked_id"], name: "index_documents_on_linked_type_and_linked_id"
  end

  create_table "donations", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.text "description"
    t.date "donated_at", null: false
    t.integer "donation_type", default: 0, null: false
    t.text "notes"
    t.bigint "partner_id"
    t.integer "payment_method", default: 0, null: false
    t.bigint "person_id"
    t.string "receipt_number"
    t.integer "recurrence_interval"
    t.boolean "recurrent", default: false, null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_donations_on_partner_id"
    t.index ["person_id"], name: "index_donations_on_person_id"
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

  create_table "health_records", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.string "clinic_name"
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.text "notes"
    t.date "occurred_at", null: false
    t.integer "record_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "vet_name"
    t.index ["animal_id"], name: "index_health_records_on_animal_id"
  end

  create_table "medication_records", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.datetime "created_at", null: false
    t.string "dosage"
    t.date "end_date"
    t.string "frequency"
    t.string "medication_name", null: false
    t.text "notes"
    t.date "start_date", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_medication_records_on_animal_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "contact_name"
    t.datetime "created_at", null: false
    t.string "document"
    t.string "email"
    t.string "name", null: false
    t.text "notes"
    t.integer "partnership_type", default: 0, null: false
    t.string "phone"
    t.date "started_at"
    t.string "state"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "website"
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
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.bigint "created_by_id"
    t.string "email"
    t.datetime "last_sign_in_at"
    t.string "name"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vaccination_records", force: :cascade do |t|
    t.date "administered_at", null: false
    t.bigint "animal_id", null: false
    t.string "batch_number"
    t.datetime "created_at", null: false
    t.date "next_due_at"
    t.text "notes"
    t.datetime "updated_at", null: false
    t.string "vaccine_name", null: false
    t.string "vet_name"
    t.index ["animal_id"], name: "index_vaccination_records_on_animal_id"
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

  create_table "weight_records", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.datetime "created_at", null: false
    t.date "measured_at", null: false
    t.text "notes"
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 5, scale: 2, null: false
    t.index ["animal_id"], name: "index_weight_records_on_animal_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adoptions", "animals"
  add_foreign_key "adoptions", "people"
  add_foreign_key "audit_logs", "users"
  add_foreign_key "complaint_updates", "complaints"
  add_foreign_key "complaints", "animals"
  add_foreign_key "deworming_records", "animals"
  add_foreign_key "document_links", "documents"
  add_foreign_key "document_signatures", "documents"
  add_foreign_key "document_signatures", "users"
  add_foreign_key "donations", "partners"
  add_foreign_key "donations", "people"
  add_foreign_key "foster_cares", "animals"
  add_foreign_key "foster_cares", "people"
  add_foreign_key "health_records", "animals"
  add_foreign_key "medication_records", "animals"
  add_foreign_key "users", "users", column: "created_by_id"
  add_foreign_key "vaccination_records", "animals"
  add_foreign_key "volunteers", "people"
  add_foreign_key "weight_records", "animals"
end
