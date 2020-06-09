Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post  '/sessions/create',  to: 'sessions#create'
  delete  '/sessions/delete',  to: 'sessions#destroy'

  post  '/users/create',  to: 'users#create'
  put  '/users/update',  to: 'users#update'
  put  '/users/update_password',  to: 'users#update_password'
  get  '/users/show_tutors',  to: 'users#show_tutors'
  get  '/users/show_tutors_by_lesson',  to: 'users#show_tutors_by_lesson'
  get  '/users/show_past_lessons',  to: 'users#show_past_lessons'
  get  '/users/show_today_lessons',  to: 'users#show_today_lessons'
  get  '/users/show_future_lessons',  to: 'users#show_future_lessons'

  get  '/cities/show',  to: 'cities#show'
  get  '/countries/show',  to: 'countries#show'

  get  '/subjects/show',  to: 'subjects#show'
  get  '/subjects/get_student_subjects',  to: 'subjects#get_student_subjects'
  get  '/subjects/get_tutor_subjects',  to: 'subjects#get_tutor_subjects'
  get  '/subjects/get_tutor_taught_subjects',  to: 'subjects#get_tutor_taught_subjects'
  
  post  '/lessons/create',  to: 'lessons#create'
  get '/lessons/get_student_lessons', to: 'lessons#get_student_lessons'
  get '/lessons/get_tutor_lessons', to: 'lessons#get_tutor_lessons'
  put '/lessons/update', to: 'lessons#update'
  delete '/lessons/delete', to: 'lessons#delete'

  get  '/tutors/show_past_lessons',  to: 'tutors#show_past_lessons'
  get  '/tutors/show_today_lessons',  to: 'tutors#show_today_lessons'
  get  '/tutors/show_future_lessons',  to: 'tutors#show_future_lessons'
  put  '/tutors/update_subjects',  to: 'tutors#update_subjects'
end
