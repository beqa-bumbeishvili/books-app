class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :number
      t.string :name
      t.string :last_name
      t.datetime :birth_date
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
