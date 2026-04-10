class CreateAdoptions < ActiveRecord::Migration[8.1]
  def change
    create_table :adoptions do |t|
      t.references :person, null: false, foreign_key: true
      t.references :animal, null: false, foreign_key: true
      t.date :applied_on
      t.integer :status
      t.text :questionnaire_answers
      t.text :notes

      t.timestamps
    end
  end
end
