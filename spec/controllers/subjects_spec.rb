# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe '#show' do
    it 'return ok status' do
      get :show
      expect(response).to have_http_status(:ok)
    end

    it 'return ok status' do
      get :show
      expect(JSON.parse(response.body)[0]['name']).to eq('spanish')
    end
  end

  describe '#get_student_subjects' do
    it 'return ok status' do
      @controller = SessionsController.new
      post :create, params: { email: 'a1@a1.com', password: '12345678' }
      @rt = JSON.parse(response.body)['remember_token']
      @controller = SubjectsController.new
      get :get_student_subjects, params: { email: 'a1@a1.com', remember_token: @rt }
      expect(response).to have_http_status(:ok)
    end

    it 'return unauthorized status' do
      @controller = SessionsController.new
      post :create, params: { email: 'b1@b1.com', password: 'asdf1234' }
      @rt = JSON.parse(response.body)['remember_token']
      @controller = SubjectsController.new
      get :get_student_subjects, params: { email: 'b1@b1.com', remember_token: @rt }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe '#get_tutor_subjects' do
    it 'return not found status' do
      @controller = SessionsController.new
      post :create, params: { email: 'a1@a1.com', password: '12345678' }
      @rt = JSON.parse(response.body)['remember_token']
      @controller = SubjectsController.new
      get :get_tutor_subjects, params: { email: 'a1@a1.com', remember_token: @rt, tutor_id: 10 }
      expect(response).to have_http_status(:not_found)
    end

    it 'get first subject name of the tutor' do
      @controller = SessionsController.new
      post :create, params: { email: 'b1@b1.com', password: 'asdf1234' }
      @rt = JSON.parse(response.body)['remember_token']
      @controller = SubjectsController.new
      get :get_tutor_subjects, params: { email: 'b1@b1.com', remember_token: @rt, tutor_id: 5 }
      expect(JSON.parse(response.body)[0]['name']).to eq('spanish')
    end
  end

  describe '#get_tutor_taught_subjects' do
    it 'return not found status' do
      @controller = SessionsController.new
      post :create, params: { email: 'a1@a1.com', password: '12345678' }
      @rt = JSON.parse(response.body)['remember_token']
      @controller = SubjectsController.new
      get :get_tutor_taught_subjects, params: { email: 'a1@a1.com', remember_token: @rt, tutor_id: 10 }
      expect(response).to have_http_status(:not_found)
    end

    it 'get first subject name of the tutor' do
      @controller = SessionsController.new
      post :create, params: { email: 'b1@b1.com', password: 'asdf1234' }
      @rt = JSON.parse(response.body)['remember_token']
      @controller = SubjectsController.new
      get :get_tutor_taught_subjects, params: { email: 'b1@b1.com', remember_token: @rt, tutor_id: 5 }
      expect(JSON.parse(response.body)[0]['name']).to eq('spanish')
    end
  end
end
