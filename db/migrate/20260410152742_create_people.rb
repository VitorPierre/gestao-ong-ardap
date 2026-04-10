class CreatePeople < ActiveRecord::Migration[8.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :cpf
      t.string :rg
      t.string :phone
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :relationship_type

      t.timestamps
    end
  end
end
