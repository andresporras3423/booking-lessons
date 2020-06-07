require 'rails_helper'

RSpec.describe "Before all", type: :model do
  context 'Before all' do
    before(:context) do
      @country1 = Country.create(name: 'Colombia', cod: 'COL')
      @country1.save

      @country2 = Country.create(name: 'Argentina', cod: 'ARG')
      @country2.save

      @country3 = Country.create(name: 'America', cod: 'USA')
      @country3.save

      @city1 = City.create(name: 'Bogotá', country_id: @country1.id)
      @city1.save

      @city2 = City.create(name: 'Buenos Aires', country_id: @country2.id)
      @city2.save

      @city3 = City.create(name: 'Miami', country_id: @country3.id)
      @city3.save

      @role1 = Role.create(name: 'student')
      @role1.save

      @role2 = Role.create(name: 'tutor')
      @role2.save

      @role3 = Role.create(name: 'administrator')
      @role3.save
  end
  end
end
