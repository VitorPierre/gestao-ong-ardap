class CreateComplaints < ActiveRecord::Migration[8.1]
  def change
    create_table :complaints do |t|
      t.string  :complainant_name
      t.string  :complainant_phone
      t.integer :category, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.string  :location_address
      t.string  :location_city
      t.string  :location_state
      t.text    :location_notes
      t.text    :description, null: false
      t.references :animal, null: true, foreign_key: true
      t.string  :assigned_to
      t.date    :resolved_on
      t.text    :notes

      t.timestamps
    end
  end
end
