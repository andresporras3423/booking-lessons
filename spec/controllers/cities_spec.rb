# spec/controllers/cities_controller_spec.rb
require 'rails_helper'

RSpec.describe CitiesController, type: :controller do

  describe "CitiesController actions" do
    it "return ok status" do
        post :show
        expect(response).to have_http_status(:ok)
    end

    it "returns the right country name for the first element" do
        post :show
        expect(JSON.parse(response.body)[0]["city_name"]).to eq("Bogotá")
  end
  end
end