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
require 'rails_helper'

RSpec.describe Plant, type: :model do
  it 'validates presence, length, and format of name' do
    invalid_plants = [
      build(:plant, name: nil),
      build(:plant, name: ''),
      build(:plant, name: 'a\nb\rc\r\nd\te'),
      build(:plant, name: ('a' * 51))
    ]

    expect(invalid_plants.map(&:valid?)).not_to include(true)
  end

  it 'validates length and format of scientific_name' do
    invalid_plants = [
      build(:plant, scientific_name: ''),
      build(:plant, scientific_name: 'a\nb\rc\r\nd\te'),
      build(:plant, scientific_name: ('a' * 101))
    ]

    expect(invalid_plants.map(&:valid?)).not_to include(true)
  end

  it 'validates length of description' do
    invalid_plants = [
      build(:plant, description: ''),
      build(:plant, description: ('a' * 1001))
    ]

    expect(invalid_plants.map(&:valid?)).not_to include(true)
  end

  it 'validates width and height to not has big value (max size of integer value)' do
    invalid_value = [
      2147483647 + 1,
      '9999999999'
    ]

    invalid_plants = [
      build(:plant, height: invalid_value.last),
      build(:plant, width: invalid_value.first),
      build(:plant, height: invalid_value.first, width: invalid_value.last)
    ]

    expect(invalid_plants.map(&:valid?)).not_to include(true)
  end

  it 'enum on water_need' do
    plant1 = build(:plant, water_need: 0)
    plant2 = build(:plant, water_need: 1)
    plant3 = build(:plant, water_need: 2)

    expect([plant1, plant2, plant3].map(&:valid?)).to all be true
    expect(plant1.low_water_need?).to eq(true)
    expect(plant2.medium_water_need?).to eq(true)
    expect(plant3.high_water_need?).to eq(true)
  end

  it 'enum on root_type' do
    plant1 = build(:plant, root_type: 0)
    plant2 = build(:plant, root_type: 1)

    expect([plant1, plant2].map(&:valid?)).to all be true
    expect(plant1.fibrous_root?).to eq(true)
    expect(plant2.tap_root?).to eq(true)
  end

  it 'has many plant note' do
    plant = create(:plant)
    note1 = create(:plant_note, plant: plant)
    note2 = create(:plant_note, plant: plant)

    expect(plant.plant_notes.length).to eq(2)
    expect(plant.plant_notes.first.id).to eq(note1.id)
    expect(plant.plant_notes.last.id).to eq(note2.id)
  end

  it 'validates that we can trust the factory' do
    plant = build(:plant)

    expect(plant.valid?).to eq(true)
  end
end
