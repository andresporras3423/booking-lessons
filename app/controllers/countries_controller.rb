# frozen_string_literal: true

class CountriesController < ApplicationController
  # Show all countries
  #
  # == HTTP_METHOD:
  #   GET
  # == Route:
  # /countries/show
  # == Headers:
  #
  # == Response:
  # render::
  #   list of countries
  # status::
  #   ok
  def show
    countries = Country.all
    render json: countries.as_json(only: %i[id name cod]), status: :ok
  end
end
