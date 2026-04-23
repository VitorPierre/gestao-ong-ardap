class AddCreatorUserIdToDocuments < ActiveRecord::Migration[8.1]
  def change
    add_column :documents, :creator_user_id, :bigint
    add_index :documents, :creator_user_id
  end
end
