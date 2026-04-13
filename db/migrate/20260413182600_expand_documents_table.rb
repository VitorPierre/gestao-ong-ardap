class ExpandDocumentsTable < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :document_type, :string
    add_column :documents, :category, :string
    add_column :documents, :status, :string, default: "draft"
    add_column :documents, :generated_at, :datetime
    add_column :documents, :signed_at, :datetime
    add_column :documents, :content, :text
    add_column :documents, :hash_signature, :string
    add_column :documents, :signer_name, :string
    add_column :documents, :signer_ip, :string
    add_column :documents, :signer_accepted_at, :datetime
    add_column :documents, :signed_by_user_id, :bigint
    add_column :documents, :is_locked, :boolean, default: false
    
    # Para vínculo polimórfico redundante mais acessível, ou futuro abandono de DocumentLink
    add_column :documents, :linked_type, :string
    add_column :documents, :linked_id, :bigint
    add_index :documents, [:linked_type, :linked_id]
  end
end
