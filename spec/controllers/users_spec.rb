# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @controller = SessionsController.new
    post :create, params: { email: 'a1@a1.com', password: '12345678' }
    @rt = JSON.parse(response.body)['remember_token']
    @controller = UsersController.new
  end

  describe '#create' do
    it 'create an new user' do
      post :create, params: { email: 'a5@a5.com', name: 'a5', city_id: 1, role_id: 1, password: '1234asdf', password_confirmation: '1234asdf' }
      expect(response).to have_http_status(:created)
    end

    it 'error while creating an user because password and password confiration are different' do
      post :create, params: { email: 'a5@a5.com', name: 'a5', city_id: 1, role_id: 1, password: '1234asdf', password_confirmation: '1234asd' }
      expect(response).to have_http_status(:conflict)
    end
  end

  describe '#update' do
    it 'returns http ok after update user' do
      put :update, params: { email: 'a1@a1.com', remember_token: @rt, name: 'a11' }
      expect(response).to have_http_status(:accepted)
    end

    it 'returns http unauthorized after trying to get today lessons with the wrong email' do
      put :update, params: { email: 'a1@a1.com', remember_token: @rt, city_id: 10 }
      expect(response).to have_http_status(:conflict)
    end
  end

  describe '#update_password' do
    it 'returns http ok after it gets future lessons' do
      put :update_password, params: { email: 'a1@a1.com', remember_token: @rt, password: 'qwerasdf', password_confirmation: 'qwerasdf' }
      expect(response).to have_http_status(:accepted)
    end

    it 'returns http unauthorized after trying to get today lessons with the wrong email' do
      put :update_password, params: { email: 'a1@a1.com', remember_token: @rt, password: 'qwera', password_confirmation: 'qwerasdf' }
      expect(response).to have_http_status(:conflict)
    end
  end

  describe '#show_tutors' do
    it 'returns http ok when called by a valid user' do
      get :show_tutors, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(response).to have_http_status(:ok)
    end

    it 'returns http unauthorized after trying to update lessons with unexistent lessons' do
      get :show_tutors, params: { email: 'b@b.com', remember_token: @rt }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe '#show_tutors_by_subject' do
    it 'show tutor with name b1' do
      get :show_tutors_by_subject, params: { email: 'a1@a1.com', remember_token: @rt, subject_id: 1 }
      expect(JSON.parse(response.body)[0]['name']).to eq('b1')
    end

    it 'show no tutors with id subject 2' do
      get :show_tutors_by_subject, params: { email: 'a1@a1.com', remember_token: @rt, subject_id: 2 }
      expect(response.body).to eq('[]')
    end
  end

  describe '#show_past_lessons' do
    it 'show no lessons before today' do
      get :show_past_lessons, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(response.body).to eq('[]')
    end

    it 'show the added lesson' do
      @lesson1 = Lesson.new(user_id: 1, tutor_id: 5, day: Date.today - 1.months, begin_hour: 10, finish_hour: 12, city_id: 2, subject_id: 1)
      @lesson1.save
      get :show_past_lessons, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(JSON.parse(response.body)[0]['tutor_id']).to eq(5)
    end
  end

  describe '#show_today_lessons' do
    it 'show no lessons for today' do
      get :show_today_lessons, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(response.body).to eq('[]')
    end

    it 'returns the created lesson for today' do
      @lesson1 = Lesson.new(user_id: 1, tutor_id: 6, day: Date.today, begin_hour: 10, finish_hour: 12, city_id: 2, subject_id: 1)
      @lesson1.save
      get :show_today_lessons, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(JSON.parse(response.body)[0]['tutor_id']).to eq(6)
    end
  end

  describe '#show_future_lessons' do
    it 'show name of tutor for onl lessons after today' do
      get :show_future_lessons, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(JSON.parse(response.body)[0]['begin_hour']).to eq(10)
    end

    it 'show id of tutor for onl lessons after today' do
      get :show_future_lessons, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(JSON.parse(response.body)[0]['tutor_id']).to eq(5)
    end
  end
end
