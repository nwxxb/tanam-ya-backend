# == Schema Information
#
# Table name: plant_notes
#
#  id          :integer          not null, primary key
#  color       :string
#  description :string
#  section     :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  plant_id    :integer
#
# Indexes
#
#  index_plant_notes_on_plant_id  (plant_id)
#
class PlantNote < ApplicationRecord
  belongs_to :plant
  validates :description,
    length: { in: 1..100 },
    allow_nil: true
  validates :color,
    length: { is: 7 },
    format: { with: /\A#[0-9A-F]{6}\z/ },
    allow_nil: true
  validates :section, presence: true
  enum section: { flower: 0, leaf: 1, fruit: 2, root: 3, trunk: 4 }
end
