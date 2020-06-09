class SubjectsController < ApplicationController
    before_action :restrict_access, only: %i[get_subjects get_tutor_subjects get_tutor_taught_subjects]
    # Show all subjects
    #
    # == HTTP_METHOD:
    #   GET
    # == Route:
    # /subjects/show
    # == Headers:
    #
    # == Response:
    # render::
    #   list of subjects
    # status::
    #   ok
    def show
        subjects = Subject.all
        render json: subjects.as_json(only: [:id, :name]), status: :ok
    end
    # Get students subjects. A subject is student subject if student has taken at least one lesson from that subject.
    #
    # == HTTP_METHOD:
    #   GET
    # == Route:
    # /subjects/get_subjects
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # == Response:
    # render::
    #   list of subjects
    # status::
    #   ok
    def get_subjects
        subjects = Hash.new
        list_subjects = Subject.all
        @user.lessons.each{|le| subjects[le.subject_id]=list_subjects.find(le.subject_id).name}
        render json: subjects.as_json, status: :ok
    end
    # Get tutor subjects
    #
    # == HTTP_METHOD:
    #   GET
    # == Route:
    # /subjects/get_tutor_subjects
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # tutor_id::
    #   id of the tutor
    # == Response:
    # render::
    #   list of subjects
    # status::
    #   ok
    def get_tutor_subjects
        subjects = User.all.find(params[:tutor_id]).subjects
        render json: subjects.as_json(only: [:id, :name]), status: :ok
    end
    # Get tutor taught subjects
    #
    # == HTTP_METHOD:
    #   GET
    # == Route:
    # /subjects/get_tutor_taught_subjects
    # == Headers:
    # email::
    #   current user email
    # remember_token::
    #   current user remember_token
    # tutor_id::
    #   id of the tutor
    # == Response:
    # render::
    #   list of subjects
    # status::
    #   ok
    def get_tutor_taught_subjects
        subjects = Hash.new
        list_subjects = Subject.all
        User.all.find(params[:tutor_id]).tutorLessons.each{|le| subjects[le.subject_id]=list_subjects.find(le.subject_id).name}
        render json: subjects.as_json, status: :ok
    end
end
