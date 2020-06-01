class CountriesController < ApplicationController
    def show
        countries = Country.all 
        render json: countries.as_json(only: [:id, :name, :cod]), status: :ok
    end
end
