class RebuildPartnersAndDonationsModule < ActiveRecord::Migration[8.1]
  def change
    drop_table :donations, force: :cascade if table_exists?(:donations)
    drop_table :partners, force: :cascade if table_exists?(:partners)

    create_table :partners do |t|
      t.string :name, null: false
      t.string :document
      t.string :contact_name
      t.string :phone
      t.string :email
      t.string :website
      t.string :address
      t.string :city
      t.string :state
      t.integer :partnership_type, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.text :notes
      t.date :started_at

      t.timestamps
    end

    create_table :donations do |t|
      t.references :partner, foreign_key: true, null: true
      t.references :person, foreign_key: true, null: true
      t.integer :donation_type, default: 0, null: false
      t.decimal :amount, precision: 10, scale: 2
      t.text :description
      t.date :donated_at, null: false
      t.boolean :recurrent, default: false, null: false
      t.integer :recurrence_interval
      t.integer :payment_method, default: 0, null: false
      t.string :receipt_number
      t.integer :status, default: 0, null: false
      t.text :notes

      t.timestamps
    end
  end
end
