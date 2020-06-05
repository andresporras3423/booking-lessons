class SubjectsController < ApplicationController
    before_action :restrict_access, only: %i[show get_subjects get_tutor_subjects get_tutor_taught_subjects]
    
    def show
        subjects = Subject.all
        render json: subjects.as_json(only: [:id, :name]), status: :ok
    end
    #A subject is student subject if he/she has taken or will take a lesson of this subject
    def get_subjects
        subjects = Hash.new
        list_subjects = Subject.all
        @user.lessons.each{|le| subjects[le.subject_id]=list_subjects.find(le.subject_id).name}
        render json: subjects.as_json, status: :ok
    end

    def get_tutor_subjects
        subjects = User.all.find(params[:tutor_id]).subjects
        render json: subjects.as_json(only: [:id, :name]), status: :ok
    end

    def get_tutor_taught_subjects
        subjects = Hash.new
        list_subjects = Subject.all
        User.all.find(params[:tutor_id]).tutorLessons.each{|le| subjects[le.subject_id]=list_subjects.find(le.subject_id).name}
        render json: subjects.as_json, status: :ok
    end
end
