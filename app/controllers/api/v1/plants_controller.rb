module Api
  module V1
    class PlantsController < ApplicationController
      def index
        render layout: false, json: []
      end
    end
  end
end
