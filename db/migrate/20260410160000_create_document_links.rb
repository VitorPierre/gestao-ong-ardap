class CreateDocumentLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :document_links do |t|
      t.references :document, null: false, foreign_key: true
      t.references :documentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
