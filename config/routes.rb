Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post  '/sessions/create',  to: 'sessions#create'
  get  '/sessions/delete',  to: 'sessions#destroy'

  post  '/users/create',  to: 'users#create'
  post  '/users/update_subjects',  to: 'users#update_subjects'
  get  '/users/show_tutors',  to: 'users#show_tutors'
  get  '/users/show_tutors_by_lesson',  to: 'users#show_tutors_by_lesson'

  get  '/cities/show',  to: 'cities#show'
  get  '/countries/show',  to: 'countries#show'
  get  '/subjects/show',  to: 'subjects#show'

  post  '/lessons/create',  to: 'lessons#create'
  get '/lessons/get_student_lessons', to: 'lessons#get_student_lessons'
  get '/lessons/get_tutor_lessons', to: 'lessons#get_tutor_lessons'
end
