class CreateDonations < ActiveRecord::Migration[8.1]
  def change
    create_table :donations do |t|
      t.references :partner, null: true, foreign_key: true
      t.references :person,  null: true, foreign_key: true
      t.integer :donation_type, null: false, default: 0
      t.decimal :amount, precision: 10, scale: 2
      t.text    :description
      t.date    :donated_on, null: false
      t.boolean :recurring, null: false, default: false
      t.string  :recurrence
      t.text    :notes

      t.timestamps
    end
  end
end
