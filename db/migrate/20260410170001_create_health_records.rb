class CreateHealthRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :health_records do |t|
      t.references :animal, null: false, foreign_key: true
      t.integer    :record_type, null: false, default: 0
      t.date       :occurred_on, null: false
      t.decimal    :weight_kg, precision: 5, scale: 2
      t.string     :veterinarian
      t.string     :clinic_location
      t.text       :diagnosis
      t.text       :treatment
      t.text       :notes
      t.date       :next_appointment

      t.timestamps
    end
  end
end
