class CreateAnimals < ActiveRecord::Migration[8.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :species
      t.integer :gender
      t.string :approximate_age
      t.string :breed
      t.integer :size
      t.decimal :weight
      t.string :color
      t.boolean :neutered
      t.boolean :vaccinated
      t.boolean :dewormed
      t.text :notes
      t.integer :status

      t.timestamps
    end
  end
end
