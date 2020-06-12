# frozen_string_literal: true

module SessionsHelper
  @user = nil

  def restrict_access
    @user = User.find_by_email(params[:email])
    unless @user&.authenticated?(params[:remember_token])
      @user = nil
      render json: { "error": 'you must be logged to do this action' }, status: :unauthorized
    end
  end

  def only_students
    msg = { "error": 'action only allowed to students' }
    allow_by_role(Role.all.find_by_name('student').id, msg)
  end

  def only_tutors
    msg = { "error": 'action only allowed to tutors' }
    allow_by_role(Role.all.find_by_name('tutor').id, msg)
  end

  def only_administrators
    msg = { "error": 'action only allowed to administrators' }
    allow_by_role(Role.all.find_by_name('administrator').id, msg)
  end

  def allow_by_role(role_id, msg)
    render json: msg, status: :unauthorized if role_id != @user.role_id
  end
  end
