# require 'rails_helper'
# require 'rspec_api_documentation/dsl'

# resource "users" do
#   post "/users/create" do
#     example "Create a new user" do
#         request = {
#               email: 'a5@a5.com',
#               name: "a5",
#               password: "12345678",
#               role_id: 1,
#               city_id: 1,
#               password_confirmation: "12345678"
#           }
#           # It's also possible to extract types of parameters when you pass data through `do_request` method.
#           do_request(request)
 
#       do_request
#       expect(status).to eq 200
#     end
#   end
# end
#post  '/users/create',  to: 'users#create'