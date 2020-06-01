module CitiesHelper
    class City_helper
        attr_accessor :city_id, :city_name, :country_id, :country_name, :country_code
       def initialize(city_id, city_name, country_id, country_name, country_code)
         @city_id = city_id
         @city_name = city_name
         @country_id = country_id
         @country_name = country_name
         @country_code = country_code
       end
     end
  end