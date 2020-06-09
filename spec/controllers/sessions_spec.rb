# spec/controllers/users_controller.rb
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    post :create, params: {email: "a1@a1.com", password: "12345678" }
     @rt = JSON.parse(response.body)["remember_token"]
  end
  describe "#create" do
    it "returns http created after create a new session" do
      expect(response).to have_http_status(:created)
    end

    it "returns http unauthorized after tryng to log with nonexistent user" do
      post :create, params: {email: "a10@a1.com", password: "12345678" }
    expect(response).to have_http_status(:unauthorized)
  end
  end

  describe "#destroy" do
    it "returns http ok after destroying current session" do
        delete :destroy, params: {email: "a1@a1.com", remember_token: @rt}
      expect(response).to have_http_status(:accepted)
    end

    it "returns http unauthorized when trying to destroy a session with invalid token" do
      delete :destroy, params: {email: "a1@a1.com", remember_token: ""}
    expect(response).to have_http_status(:unauthorized)
  end
  end
end