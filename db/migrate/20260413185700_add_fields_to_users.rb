class AddFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :active, :boolean, default: true, null: false
    add_column :users, :created_by_id, :bigint
    add_column :users, :last_sign_in_at, :datetime

    add_foreign_key :users, :users, column: :created_by_id
  end
end
