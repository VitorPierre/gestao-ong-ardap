class CreateFosterCares < ActiveRecord::Migration[8.1]
  def change
    create_table :foster_cares do |t|
      t.references :person, null: false, foreign_key: true
      t.references :animal, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.text :notes

      t.timestamps
    end
  end
end
