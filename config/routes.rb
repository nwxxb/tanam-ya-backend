Rails.application.routes.draw do
  namespace :admin do
    resources :plants
    resources :plant_notes, except: :index

    root to: "plants#index"
  end

  namespace :api do
    namespace :v1 do
      resources :plants, only: [:index]
    end
  end
end
