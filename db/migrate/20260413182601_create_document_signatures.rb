class CreateDocumentSignatures < ActiveRecord::Migration[8.1]
  def change
    create_table :document_signatures do |t|
      t.references :document, null: false, foreign_key: true
      t.string :signer_name
      t.string :signer_ip
      t.boolean :accepted_terms, default: true, null: false
      t.datetime :signed_at
      t.references :user, foreign_key: true, null: true
      t.string :content_hash

      t.timestamps
    end
  end
end
