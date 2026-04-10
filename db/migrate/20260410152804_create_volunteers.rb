class CreateVolunteers < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteers do |t|
      t.references :person, null: false, foreign_key: true
      t.string :availability
      t.string :activity_type
      t.boolean :image_use_authorized

      t.timestamps
    end
  end
end
