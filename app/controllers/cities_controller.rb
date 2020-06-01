class CitiesController < ApplicationController
    def show
        cities = City.all 
        cities_json = cities.map{|c| City_helper.new(c.id, c.name, c.country.id, c.country.name, c.country.cod)}
        render json: cities_json.as_json, status: :ok
    end
end
