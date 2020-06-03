module LessonsHelper
    class Lesson_helper
        attr_accessor :lesson_id, :user_id, :tutor_id, :day, :begin_hour, :finish_hour, :subject_id, :user_name, :tutor_name, :subject_name, :city_id, :city_name 
       def initialize(lesson)
         @lesson_id = lesson.id
         @user_id = lesson.user_id
         @tutor_id = lesson.tutor_id
         @day = lesson.day
         @begin_hour = lesson.begin_hour
         @finish_hour = lesson.finish_hour
         @subject_id = lesson.subject_id
         @user_name = lesson.user.name
         @subject_name = lesson.subject.name
         @tutor_name = lesson.tutor.name
         @city_id = lesson.city_id
         @city_name = lesson.city.name
       end
     end
end