Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post  '/sessions/create',  to: 'sessions#create'
  get  '/sessions/delete',  to: 'sessions#destroy'

  post  '/users/create',  to: 'users#create'
  post  '/users/update_subjects',  to: 'users#update_subjects'

  get  '/cities/show',  to: 'cities#show'
  get  '/countries/show',  to: 'countries#show'
  get  '/subjects/show',  to: 'subjects#show'
end
