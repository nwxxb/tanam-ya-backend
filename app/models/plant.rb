# == Schema Information
#
# Table name: plants
#
#  id              :integer          not null, primary key
#  description     :text
#  height          :integer
#  name            :string           not null
#  root_type       :integer
#  scientific_name :string
#  water_need      :integer
#  width           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Plant < ApplicationRecord
  validates :name,
    length: { in: 1..50 },
    format: { with: /\A[A-Za-z0-9\-\ ]+\z/ },
    presence: true
  validates :scientific_name,
    format: { with: /\A[A-Za-z0-9\-\ ]+\z/ },
    length: { in: 1..100 },
    allow_nil: true
  validates :description,
    length: { in: 1..1000 },
    allow_nil: true
  validates :width,
    numericality: { only_integer: true, in: 1..1_000_000 },
    allow_nil: true
  validates :height,
    numericality: { only_integer: true, in: 1..1_000_000 },
    allow_nil: true
  enum root_type: { fibrous: 0, tap: 1 }, _suffix: :root
  enum water_need: { low: 0, medium: 1, high: 2 }, _suffix: true

  has_many :plant_notes
  accepts_nested_attributes_for(
    :plant_notes,
    reject_if: :all_blank,
    allow_destroy: true
  )
end
