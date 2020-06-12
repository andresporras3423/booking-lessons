# frozen_string_literal: true

class TutorsController < ApplicationController
  before_action :restrict_access, :only_tutors

  # Show before today lessons for the current user (only tutors)
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /tutors/show_past_lessons
  # == Headers:
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  #
  # == Response:
  # render::
  #   list of lessons
  # status::
  #   ok
  def show_past_lessons
    lessons = @user.tutorLessons
    lessons_helper = lessons.select { |le| le.day < Date.today }
    render json: lessons_helper, status: :ok
  end

  # Show today lessons for the current user (only tutors)
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /tutors/show_today_lessons
  # == Headers:
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  #
  # == Response:
  # render::
  #   list of lessons
  # status::
  #   ok
  def show_today_lessons
    lessons = @user.tutorLessons
    lessons_helper = lessons.select { |le| le.day == Date.today }
    render json: lessons_helper, status: :ok
  end

  # Show after today lessons for the current user (only tutors)
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /tutors/show_future_lessons
  # == Headers:
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  #
  # == Response:
  # render::
  #   list of lessons
  # status::
  #   ok
  def show_future_lessons
    lessons = @user.tutorLessons
    lessons_helper = lessons.select { |le| le.day > Date.today }
    render json: lessons_helper, status: :ok
  end

  # update list of subject of current user (only tutors)
  #
  # == HTTP_METHOD:
  # PUT
  # == Route:
  # /tutors/update_subjects
  # == Headers:
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  # sub_ids::
  #   list of subjects ids, separated by comma
  #
  # == Response:
  # render::
  #   message of status update
  # status::
  #   accepted
  def update_subjects
    sub_ids = params[:sub_ids]
    @user.userSubjects.each(&:destroy)
    user_subjects = sub_ids.split(',').each do |s_id|
      u1 = UserSubject.new(user_id: @user.id, subject_id: s_id.to_i)
      unless u1.valid?
        render json: { "error": 'subject id not found' }, status: :not_found
        return
      end
      u1.save
    end
    render json: JSON[{ "status": 'updated' }], status: :accepted
  end
end
