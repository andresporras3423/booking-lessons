# frozen_string_literal: true

class CitiesController < ApplicationController
  # Show all cities
  #
  # == HTTP_METHOD:
  #   GET
  # == Route:
  # /cities/show
  # == Headers:
  #
  # == Response:
  # render::
  #   list of cities
  # status::
  #   ok
  def show
    cities = City.all
    cities_json = cities.map { |c| City_helper.new(c.id, c.name, c.country.id, c.country.name, c.country.cod) }
    render json: cities_json.as_json, status: :ok
  end
end
