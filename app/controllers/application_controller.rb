# frozen_string_literal: true

class ApplicationController < ActionController::API
  include SessionsHelper
  include CitiesHelper
  include LessonsHelper
end
