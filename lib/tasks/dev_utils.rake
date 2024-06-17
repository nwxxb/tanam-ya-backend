if Rails.env.development?
  namespace :dev do
    # - only doing this in development
    # - You need to run seeder too:
    #   this task only generate some example for development. Not default value that this apps needed
    task generate_example_data: [:environment] do
      # maybe in the future, we need factory bot to dry this up
      # require 'factory_bot'

      # If you run this rake tasks. it will destroy all Plant listed in DEVELOPMENT database
      # when this project grow and more fields added. maybe we can grow this seeder too so we can keep track
      # all object 'conditions' and don't litter our development environment with some untracked garbage data
      Plant.destroy_all

      # plant with no note
      Plant.create(
        name: 'Moss', scientific_name: 'Bryophyta',
        description: 'A description of a green moss',
        height: 1, width: 1, root_type: nil, water_need: :high
      )

      # plant with a note
      daisy = Plant.create(
        name: 'Daisy', scientific_name: 'Bellis perennis',
        description: 'A description of a daisy',
        height: 11, width: 12, root_type: :fibrous, water_need: :medium
      )

      daisy.plant_notes = [
        PlantNote.create(
          section: :flower,
          color: '#FFFFFF',
          description: 'beautiful white flower'
        )
      ]

      # plant with three note
      water_melon = Plant.create(
        name: 'Watermelon', scientific_name: 'Citrullus lanatus',
        description: 'A description of a green big watermelon',
        height: 30, width: 300, root_type: :tap, water_need: :high
      )

      water_melon.plant_notes = [
        PlantNote.create(
          section: :fruit,
          color: '#355E3B',
          description: 'Big red watermelon fruit'
        ),
        PlantNote.create(
          section: :trunk,
          color: '#355E3B',
          description: 'bush-like body'
        ),
        PlantNote.create(
          section: :flower,
          color: '#FFFF00',
          description: 'small and yellow flower'
        )
      ]
    end
  end
end
