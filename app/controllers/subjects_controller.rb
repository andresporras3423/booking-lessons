class SubjectsController < ApplicationController
    before_action :restrict_access, only: %i[get_student_subjects get_tutor_subjects get_tutor_taught_subjects]
    before_action :only_students, only: %i[get_student_subjects] 
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
    def get_student_subjects
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
        begin
            tutor = User.all.find(params[:tutor_id])
            if tutor.role_id != Role.all.find_by_name("tutor").id
                render json: {"error": "this is not the id of a tutor user"}, status: :conflict
            else
                subjects = tutor.subjects
                render json: subjects.as_json(only: [:id, :name]), status: :ok
            end
        rescue => exception
            render json: {"error": "tutor not found"}, status: :not_found
        end
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
        begin
            tutor = User.all.find(params[:tutor_id])
            if tutor.role_id != Role.all.find_by_name("tutor").id
                render json: {"error": "this is not the id of a tutor user"}, status: :conflict
            else
                subjects = Hash.new
                list_subjects = Subject.all
                tutor.tutorLessons.each{|le| subjects[le.subject_id]=list_subjects.find(le.subject_id)}
                tutor_subjects = []
                 subjects.each {|key, value| tutor_subjects.push(value) }
                render json: tutor_subjects.as_json, status: :ok
            end
        rescue => exception
            render json: {"error": "tutor not found"}, status: :not_found
        end
        # subjects = Hash.new
        # list_subjects = Subject.all
        # User.all.find(params[:tutor_id]).tutorLessons.each{|le| subjects[le.subject_id]=list_subjects.find(le.subject_id).name}
        # render json: subjects.as_json, status: :ok
    end
end
