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
FactoryBot.define do
  factory :plant do
    name { "Daisy" }
    scientific_name { 'Bellis perennis' }
    description { 'A description of a daisy' }
    height { 11 }
    width { 12 }
    root_type { 0 }
    water_need { 1 }
  end
end
