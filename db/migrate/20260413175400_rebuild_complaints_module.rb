class RebuildComplaintsModule < ActiveRecord::Migration[8.1]
  def change
    drop_table :complaints, force: :cascade

    create_table :complaints do |t|
      t.string :protocol_number, null: false
      t.integer :category, default: 0, null: false
      t.text :description, null: false
      t.string :location_address
      t.string :location_city
      t.string :location_reference
      t.string :complainant_name
      t.string :complainant_phone
      t.boolean :anonymous, default: false, null: false
      t.integer :status, default: 0, null: false
      t.integer :priority, default: 0, null: false
      t.datetime :received_at, null: false
      t.datetime :resolved_at
      t.string :assigned_to
      t.references :animal, foreign_key: true
      t.text :notes

      t.timestamps
    end
    add_index :complaints, :protocol_number, unique: true

    create_table :complaint_updates do |t|
      t.references :complaint, null: false, foreign_key: true
      t.text :description
      t.integer :status_changed_to
      t.string :author

      t.timestamps
    end
  end
end
