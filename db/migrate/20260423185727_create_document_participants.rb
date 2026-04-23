class CreateDocumentParticipants < ActiveRecord::Migration[8.1]
  def change
    create_table :document_participants do |t|
      t.references :document, null: false, foreign_key: true
      t.string :full_name
      t.string :document_number
      t.integer :document_kind
      t.string :phone
      t.string :email
      t.string :address
      t.integer :role_in_document
      t.integer :external_type
      t.text :notes
      t.boolean :signed, default: false

      t.timestamps
    end
  end
end
