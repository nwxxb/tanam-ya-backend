class CreatePlantNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :plant_notes do |t|
      t.integer :section, null: false, default: 0
      t.string :description
      t.string :color
      t.references :plant

      t.timestamps
    end
  end
end
