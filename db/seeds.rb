# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@country1 = Country.new(name: 'Colombia', cod: 'COL')
@country1.save
@country2 = Country.new(name: 'Argentina', cod: 'ARG')
@country2.save
@country3 = Country.new(name: 'America', cod: 'USA')
@country3.save

@city1 = City.new(name: 'Bogotá', country_id: @country1.id)
@city1.save
@city2 = City.new(name: 'Buenos Aires', country_id: @country2.id)
@city2.save
@city3 = City.new(name: 'Miami', country_id: @country3.id)
@city3.save

@role1 = Role.new(name: 'student')
@role1.save
@role2 = Role.new(name: 'tutor')
@role2.save
@role3 = Role.new(name: 'administrator')
@role3.save

@subject1 = Subject.new(name: 'spanish')
@subject1.save
@subject2 = Subject.new(name: 'english')
@subject2.save

@user1 = User.create(name: 'a1', email: 'a1@a1.com', password: '12345678', password_confirmation: '12345678', role_id: 1, city_id: 1)
@user1.save
@user2 = User.create(name: 'a2', email: 'a2@a2.com', password: '12345678', password_confirmation: '12345678', role_id: 1, city_id: 1)
@user2.save
@user3 = User.create(name: 'a3', email: 'a3@a3.com', password: '12345678', password_confirmation: '12345678', role_id: 1, city_id: 2)
@user3.save
@user4 = User.create(name: 'a4', email: 'a4@a4.com', password: '12345678', password_confirmation: '12345678', role_id: 1, city_id: 2)
@user4.save
@tutor1 = User.create(name: 'b1', email: 'b1@b1.com', password: 'asdf1234', password_confirmation: 'asdf1234', role_id: 2, city_id: 1)
@tutor1.save
@tutor2 = User.create(name: 'b2', email: 'b2@b2.com', password: 'asdf1234', password_confirmation: 'asdf1234', role_id: 2, city_id: 1)
@tutor2.save
@tutor3 = User.create(name: 'b3', email: 'b3@b3.com', password: 'asdf1234', password_confirmation: 'asdf1234', role_id: 2, city_id: 2)
@tutor3.save
@tutor4 = User.create(name: 'b4', email: 'b4@b4.com', password: 'asdf1234', password_confirmation: 'asdf1234', role_id: 2, city_id: 2)
@tutor4.save

@userSubject1 = UserSubject.new(user_id: 5, subject_id: 1)
@userSubject1.save
@userSubject2 = UserSubject.new(user_id: 6, subject_id: 1)
@userSubject2.save
@userSubject3 = UserSubject.new(user_id: 7, subject_id: 1)
@userSubject3.save
@userSubject4 = UserSubject.new(user_id: 8, subject_id: 1)
@userSubject4.save
@lesson1 = Lesson.new(user_id: 1, tutor_id: 5, day: Date.today + 1.months, begin_hour: 10, finish_hour: 12, city_id: 2, subject_id: 1)
@lesson1.save
