class RebuildHealthRecordsModule < ActiveRecord::Migration[8.1]
  def change
    drop_table :health_records

    create_table :health_records do |t|
      t.references :animal, null: false, foreign_key: true
      t.integer :record_type, default: 0, null: false
      t.text :description, null: false
      t.string :vet_name
      t.string :clinic_name
      t.date :occurred_at, null: false
      t.text :notes
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    create_table :vaccination_records do |t|
      t.references :animal, null: false, foreign_key: true
      t.string :vaccine_name, null: false
      t.string :batch_number
      t.date :administered_at, null: false
      t.date :next_due_at
      t.string :vet_name
      t.text :notes

      t.timestamps
    end

    create_table :deworming_records do |t|
      t.references :animal, null: false, foreign_key: true
      t.string :product_name, null: false
      t.date :administered_at, null: false
      t.date :next_due_at
      t.text :notes

      t.timestamps
    end

    create_table :medication_records do |t|
      t.references :animal, null: false, foreign_key: true
      t.string :medication_name, null: false
      t.string :dosage
      t.string :frequency
      t.date :start_date, null: false
      t.date :end_date
      t.integer :status, default: 0, null: false
      t.text :notes

      t.timestamps
    end

    create_table :weight_records do |t|
      t.references :animal, null: false, foreign_key: true
      t.decimal :weight, precision: 5, scale: 2, null: false
      t.date :measured_at, null: false
      t.text :notes

      t.timestamps
    end
  end
end
