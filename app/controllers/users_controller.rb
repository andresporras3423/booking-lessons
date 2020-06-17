# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :restrict_access, only: %i[update show_tutors show_tutors_by_subject show_past_lessons show_today_lessons show_future_lessons update_password]
  # show link to repository and documentation
  def index
    render json: {"API documentation": "http://andresporres.000webhostapp.com/booking-lessons/_index.html","Github repository": "https://github.com/andresporras3423/booking-lessons"}, status: :ok
  end
  # Create a new user
  #
  # == HTTP_METHOD:
  # POST
  # == Route:
  # /users/create
  # == Headers:
  # name::
  #   User name, not null
  # email::
  #   User email, not null, it has to be a valid email and unique
  # role_id::
  #   id of the user role, not null, there are three roles, 1=student, 2=tutor and 3=administrator
  # city_id::
  #   id of the user city, not null
  #
  # == Response:
  # render::
  #   User id, name, email, remember_token
  # status::
  #   created
  def create
    user = User.create(name: params[:name], email: params[:email], password: params[:password],
                       password_confirmation: params[:password_confirmation], city_id: params[:city_id], role_id: params[:role_id])
    if user.valid?
      user.record_signup
      user.save
      render json: user.as_json(only: %i[id email name remember_token]), status: :created
    else
      render json: user.errors.messages, status: :conflict
    end
  end

  # Update parameter values of current user
  #
  # == HTTP_METHOD:
  # PUT
  # == Route:
  # /users/update
  # == Headers:
  # name::
  #   User name
  # new_eail::
  #   New user email, it has to be a valid email and unique
  # role_id::
  #   id of the user role, there are three roles, 1=student, 2=tutor and 3=administrator
  # city_id::
  #   id of the user city
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  # == Response:
  # render::
  #   User id, name, email
  # status::
  #   accepted
  def update
    @user.name = params[:name].nil? ? @user.name : params[:name]
    @user.email = params[:new_email].nil? ? @user.email : params[:new_email]
    @user.city_id = params[:city_id].nil? ? @user.city_id : params[:city_id]
    if @user.valid?
      @user.save
      render json: @user.as_json(only: %i[id email name]), status: :accepted
    else
      render json: @user.errors.messages, status: :conflict
    end
  end

  # Update password of current user
  #
  # == HTTP_METHOD:
  # PUT
  # == Route:
  # /users/update_password
  # == Headers:
  # password::
  #   the user password must have at least 4 characters
  # password_confirmation::
  #   it must have the same value of password
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  # == Response:
  # render::
  #   User id, name, email, remember_token
  # status::
  #   accepted
  def update_password
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.valid?
      @user.record_signup
      @user.save
      render json: @user.as_json(only: %i[id email name remember_token]), status: :accepted
    else
      render json: @user.errors.messages, status: :conflict
    end
  end

  # Show available tutors in user's city
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /users/show_tutors
  # == Headers:
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  #
  # == Response:
  # render::
  #  == list tutors
  #     id, name, email, name
  # status::
  #   ok
  def show_tutors
    tutors = User.all.select { |t| t.role.name == 'tutor' && t.city_id == @user.city_id }
    render json: tutors.as_json(only: %i[id email name]), status: :ok
  end

  # Filter by subject the tutors in the city of current user
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /users/show_tutors_by_subject
  # == Headers:
  # email::
  #   current user email
  # remember_token::
  #   current user remember_token
  # subject_id::
  #   id of the subject to use for filtering tutors un user's city
  #
  # == Response:
  # render::
  #  == list tutors
  #     id, name, email, name
  # status::
  #   ok
  def show_tutors_by_subject
    tutors = User.all.select { |t| t.role.name == 'tutor' && t.city_id == @user.city_id && t.userSubjects.any? { |us| params[:subject_id].to_i == us.subject_id } }
    render json: tutors.as_json(only: %i[id email name]), status: :ok
  end

  # Show before today lessons for the current user (just students)
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /users/show_past_lessons
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
    lessons = @user.lessons
    lessons_helper = lessons.select { |le| le.day < Date.today }
    render json: lessons_helper, status: :ok
  end

  # Show today lessons for the current user (just students)
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /users/show_today_lessons
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
    lessons = @user.lessons
    lessons_helper = lessons.select { |le| le.day == Date.today }
    render json: lessons_helper, status: :ok
  end

  # Show after today lessons for the current user (just students)
  #
  # == HTTP_METHOD:
  # GET
  # == Route:
  # /users/show_future_lessons
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
    lessons = @user.lessons
    lessons_helper = lessons.select { |le| le.day > Date.today }
    render json: lessons_helper, status: :ok
  end
end
