# spec/controllers/articles_controller_spec.rb
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    before(:each) do
        post :create, params: {email: "a1@a1.com", password: "12345678" }
         @rt = JSON.parse(response.body)["remember_token"]
      end
    it "returns http created after create a new session" do
      expect(response).to have_http_status(:created)
    end

    it "returns http ok after destroying current session" do
        delete :destroy, params: {email: "a1@a1.com", remember_token: @rt}
      expect(response).to have_http_status(:accepted)
    end

  end
end