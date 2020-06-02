class SubjectsController < ApplicationController
    def show
        subjects = Subject.all
        render json: subjects.as_json(only: [:id, :name]), status: :ok
    end
end
