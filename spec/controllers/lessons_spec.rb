# frozen_string_literal: true

# spec/controllers/users_controller.rb
require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  before(:each) do
    @controller = SessionsController.new
    post :create, params: { email: 'a1@a1.com', password: '12345678' }
    @rt = JSON.parse(response.body)['remember_token']
    @controller = LessonsController.new
  end

  describe '#create' do
    it 'create an new lesson' do
      post :create, params: { email: 'a1@a1.com', remember_token: @rt, user_id: 1, tutor_id: 6, day: Date.today, begin_hour: 10, finish_hour: 12, city_id: 2, subject_id: 1 }
      expect(response).to have_http_status(:created)
    end

    it 'error while creating an user because password and password confiration are different' do
      post :create, params: { email: 'a1@a1.com', remember_token: @rt, user_id: 1, tutor_id: 6, day: Date.today, begin_hour: 13, finish_hour: 12, city_id: 2, subject_id: 1 }
      expect(response).to have_http_status(:conflict)
    end
  end

  describe '#update' do
    it 'returns http ok after update user' do
      lesson_id = Lesson.all.find(1).id
      put :update, params: { email: 'a1@a1.com', remember_token: @rt, tutor_id: 5, lesson_id: lesson_id }
      expect(response).to have_http_status(:accepted)
    end

    it 'returns http unauthorized after trying to get today lessons with the wrong email' do
      lesson_id = Lesson.all.find(1).id
      put :update, params: { email: 'a1@a1.com', remember_token: @rt, begin_hour: 23, lesson_id: lesson_id }
      expect(response).to have_http_status(:conflict)
    end
  end

  describe '#delete' do
    it 'returns http accepted after delete lesson' do
      lesson_id = Lesson.all.find(1).id
      delete :delete, params: { email: 'a1@a1.com', remember_token: @rt, lesson_id: lesson_id }
      expect(response).to have_http_status(:accepted)
    end

    it 'returns http forbidden when trying to delete a today lesson' do
      lesson = Lesson.all.find(1)
      lesson.day = Date.today
      lesson.save
      delete :delete, params: { email: 'a1@a1.com', remember_token: @rt, lesson_id: lesson.id }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe '#get_student_lessons' do
    it 'returns lesson with tutor_id= 5' do
      get :get_student_lessons, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(JSON.parse(response.body)[0]['tutor_id']).to eq(5)
    end

    it 'returns ok status for this action' do
      get :get_student_lessons, params: { email: 'a1@a1.com', remember_token: '' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe '#get_tutor_lessons' do
    it 'returns lesson with tutor_id= 5' do
      get :get_tutor_lessons, params: { email: 'a1@a1.com', remember_token: @rt, tutor_id: 5 }
      expect(JSON.parse(response.body)[0]['tutor_id']).to eq(5)
    end

    it 'returns ok status for this action' do
      get :get_tutor_lessons, params: { email: 'a1@a1.com', remember_token: @rt, tutor_id: 6 }
      expect(JSON.parse(response.body)[0]).to eq(nil)
    end
  end
end
