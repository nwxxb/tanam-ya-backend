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
FactoryBot.define do
  factory :plant_note do
    color { '#EE0943' }
    description { 'Note about this plant' }
    section { 0 }
    plant
  end
end
