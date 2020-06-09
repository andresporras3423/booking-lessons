# spec/controllers/users_controller.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @controller = SessionsController.new
    post :create, params: {email: "b1@b1.com", password: "asdf1234" }
     @rt = JSON.parse(response.body)["remember_token"]
     @controller = TutorsController.new
  end
  describe "#show_past_lessons" do
    it "returns http ok after it gets past lessons" do
        get :show_past_lessons, params: {email: "b1@b1.com", remember_token: @rt}
      expect(response).to have_http_status(:ok)
    end

    it "returns http unauthorized after trying to get past lessons with student role" do
        @controller = SessionsController.new
        post :create, params: {email: "a1@a1.com", password: "12345678" }
        rt_student = JSON.parse(response.body)["remember_token"]
        @controller = TutorsController.new
        get :show_past_lessons, params: {email: "a1@a1.com", remember_token: rt_student }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "#show_today_lessons" do
    it "returns http ok after it gets today lessons" do
        get :show_today_lessons, params: {email: "b1@b1.com", remember_token: @rt}
      expect(response).to have_http_status(:ok)
    end

    it "returns http unauthorized after trying to get today lessons with the wrong email" do
        get :show_today_lessons, params: {email: "b@b.com", remember_token: @rt}
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "#show_future_lessons" do
    it "returns http ok after it gets future lessons" do
        get :show_future_lessons, params: {email: "b1@b1.com", remember_token: @rt}
      expect(response).to have_http_status(:ok)
    end

    it "returns http unauthorized after trying to get today lessons with the wrong email" do
        get :show_future_lessons, params: {email: "b1@b1.com", remember_token: @rt}
      expect(JSON.parse(response.body)[0]["user_id"]).to eq(1)
    end
  end

  describe "#update_subjects" do
    it "returns http ok after update lessons" do
        put :update_subjects, params: {email: "b1@b1.com", remember_token: @rt, sub_ids: '1,2'}
      expect(response).to have_http_status(:accepted)
    end

    it "returns http unauthorized after trying to update lessons with unexistent lessons" do
        put :update_subjects, params: {email: "b1@b1.com", remember_token: @rt, sub_ids: '2,3'}
      expect(response).to have_http_status(:not_found)
    end
  end
end