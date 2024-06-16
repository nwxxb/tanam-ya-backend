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
require 'rails_helper'

RSpec.describe PlantNote, type: :model do
  it 'validates and enum section' do
    invalid_note = build(:plant_note, section: nil)
    note1 = build(:plant_note, section: 0, description: 'Big red rose flower')
    note2 = build(:plant_note, section: 1, description: 'Big green rose leaves')
    note3 = build(:plant_note, section: 2, description: 'There is no fruit :(')
    note4 = build(:plant_note, section: 3, description: 'long tap root')
    note5 = build(:plant_note, section: 4, description: 'with sharp trunk')

    expect(invalid_note.valid?).to eq(false)
    expect([note1, note2, note3, note4, note5].map(&:valid?)).to all be true
    expect(note1.flower?).to eq(true)
    expect(note2.leaf?).to eq(true)
    expect(note3.fruit?).to eq(true)
    expect(note4.root?).to eq(true)
    expect(note5.trunk?).to eq(true)
  end

  it 'validates length of description' do
    invalid_notes = [
      build(:plant_note, description: ''),
      build(:plant_note, description: ('a' * 101))
    ]

    expect(invalid_notes.map(&:valid?)).not_to include(true)
  end

  it 'validates format of color (in hexadecimal)' do
    invalid_notes = [
      build(:plant_note, color: ''),
      build(:plant_note, color: 'red'),
      build(:plant_note, color: 'EE0943'),
      build(:plant_note, color: '#EE094'),
      build(:plant_note, color: '#ee0943')
    ]

    expect(invalid_notes.map(&:valid?)).not_to include(true)
  end

  it 'belongs to a plant' do
    plant = create(:plant)
    notes = create(:plant_note, plant: plant)

    expect(notes.plant.id).to eq(plant.id)
  end

  it 'validates that we can trust the factory' do
    note = build(:plant_note)

    expect(note.valid?).to eq(true)
  end
end
