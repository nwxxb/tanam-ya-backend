# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_06_15_113832) do
  create_table "plant_notes", force: :cascade do |t|
    t.integer "section", default: 0, null: false
    t.string "description"
    t.string "color"
    t.integer "plant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_plant_notes_on_plant_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name", null: false
    t.string "scientific_name"
    t.text "description"
    t.integer "height"
    t.integer "width"
    t.integer "root_type"
    t.integer "water_need"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
