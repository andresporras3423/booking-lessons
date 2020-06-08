require 'rails_helper'
require 'before_spec'

RSpec.describe UserSubject, type: :model do
  context 'UserSubject model creation' do
    let(:us1) { UserSubject.new(user_id: 1, subject_id: 1) }
    it 'valid UserSubject' do
        p User.all
      expect(us1.valid?).to eq(true)
    end

    it 'invalid UserSubject by noexisting user_id' do
      s2 = UserSubject.new(user_id: 2, subject_id: 1)
      expect(s2.valid?).to eq(false)
    end

    it 'invalid UserSubject by nonexisting subject_id' do
        s2 = UserSubject.new(user_id: 1, subject_id: 5)
      expect(s2.valid?).to eq(false)
    end
  end
end