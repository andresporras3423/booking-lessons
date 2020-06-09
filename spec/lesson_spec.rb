require 'rails_helper'

RSpec.describe Lesson, type: :model do
  context 'Lesson model creation' do
    let(:l1) { Lesson.new(user_id: 1, tutor_id:5, day: Date.today+3.months, begin_hour: 10, finish_hour: 12, city_id: 1, subject_id: 1) }
    let(:l2) { Lesson.new(user_id: 2, tutor_id:6, day: Date.today+2.months+1.days, begin_hour: 10, finish_hour: 12, city_id: 2, subject_id: 1) }
    before(:each) do
      l1.save
      l2.save
    end
    it 'valid Lesson' do
      expect(l1.valid?).to eq(true)
    end

    it 'invalid Lesson by overlapping class with other student class' do
      l3 = Lesson.new(user_id: 1, tutor_id:7, day: Date.today+3.months, begin_hour: 10, finish_hour: 12, city_id: 1, subject_id: 1)
      expect(l3.valid?).to eq(false)
    end

    it 'invalid Lesson by overlapping class with other tutor class' do
        l3 = Lesson.new(user_id: 2, tutor_id:5, day: Date.today+3.months, begin_hour: 10, finish_hour: 12, city_id: 1, subject_id: 1)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson by invalid begin hour' do
        l3 = Lesson.new(user_id: 2, tutor_id:5, day: Date.today+2.months+2.days, begin_hour: -1, finish_hour: 12, city_id: 1, subject_id: 1)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson by invalid finish hour' do
        l3 = Lesson.new(user_id: 2, tutor_id:5, day: Date.today+2.months+2.days, begin_hour: 6, finish_hour: 35, city_id: 1, subject_id: 1)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson by begin hour equal or bigger than finish hour' do
        l3 = Lesson.new(user_id: 2, tutor_id:5, day: Date.today+2.months+2.days, begin_hour: 13, finish_hour: 12, city_id: 1, subject_id: 1)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson because lesson subject is not a tutor subject' do
        l3 = Lesson.new(user_id: 2, tutor_id:5, day: Date.today+2.months+2.days, begin_hour: 10, finish_hour: 12, city_id: 1, subject_id: 2)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson by user not being student role' do
        l3 = Lesson.new(user_id: 7, tutor_id:8, day: Date.today+2.months+2.days, begin_hour: 10, finish_hour: 12, city_id: 2, subject_id: 1)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson by tutor not being tutor role' do
        l3 = Lesson.new(user_id: 3, tutor_id:4, day: Date.today+2.months+2.days, begin_hour: 10, finish_hour: 12, city_id: 2, subject_id: 1)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson by nonexistent subject' do
        l3 = Lesson.new(user_id: 2, tutor_id:5, day: Date.today+2.months+2.days, begin_hour: 10, finish_hour: 12, city_id: 1, subject_id: 5)
        expect(l3.valid?).to eq(false)
      end

      it 'invalid Lesson by nonexistent city_id' do
        l3 = Lesson.new(user_id: 2, tutor_id:5, day: Date.today+2.months+2.days, begin_hour: 10, finish_hour: 12, city_id: 5, subject_id: 1)
        expect(l3.valid?).to eq(false)
      end
  end
end