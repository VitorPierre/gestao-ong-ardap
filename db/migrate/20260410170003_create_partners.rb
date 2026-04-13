class CreatePartners < ActiveRecord::Migration[8.1]
  def change
    create_table :partners do |t|
      t.string  :name, null: false
      t.integer :partner_type, null: false, default: 0
      t.string  :email
      t.string  :phone
      t.string  :address
      t.string  :city
      t.string  :state
      t.string  :contact_name
      t.text    :notes
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
