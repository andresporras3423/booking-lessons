class ApplicationController < ActionController::API
    include SessionsHelper
    include CitiesHelper
    include LessonsHelper
end
