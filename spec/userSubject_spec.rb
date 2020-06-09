# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSubject, type: :model do
  context 'UserSubject model creation' do
    let(:us1) { UserSubject.new(user_id: 5, subject_id: 2) }
    it 'valid UserSubject' do
      expect(us1.valid?).to eq(true)
    end

    it 'invalid UserSubject by noexisting user_id' do
      us2 = UserSubject.new(user_id: 10, subject_id: 1)
      expect(us2.valid?).to eq(false)
    end

    it 'invalid UserSubject by nonexisting subject_id' do
      us2 = UserSubject.new(user_id: 1, subject_id: 5)
      expect(us2.valid?).to eq(false)
    end
  end
end
