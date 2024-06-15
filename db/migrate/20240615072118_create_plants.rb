class CreatePlants < ActiveRecord::Migration[7.0]
  def change
    create_table :plants do |t|
      t.string :name, null: false
      t.string :scientific_name
      t.text :description
      t.integer :height
      t.integer :width
      t.integer :root_type
      t.integer :water_need

      t.timestamps
    end
  end
end
