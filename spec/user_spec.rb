require 'rails_helper'

RSpec.describe User, type: :model do
  context 'user model creation' do
    let(:u1) { User.create(name: 'Oscar', email: 'o@o.com', password: '12345678', password_confirmation: '12345678', role_id:1, city_id:1) }
    before(:each) do
      u1.save
    end
    it 'valid user' do
      expect(u1.valid?).to eq(true)
    end

    it 'invalid user by existing email' do
      u2 = User.create(name: 'Andrés', email: 'o@o.com',
                       password: '1234567', password_confirmation: '1234567', role_id:1, city_id:1)
      expect(u2.valid?).to eq(false)
    end

    it 'invalid user by short password' do
      u2 = User.create(name: 'Camilo', email: 'q1@q.com',
                       password: '123', password_confirmation: '123', role_id:1, city_id:1)
      expect(u2.valid?).to eq(false)
    end

    it 'invalid user by different pasword and password_confirmations' do
      u2 = User.create(name: 'Oscar andres', email: 'q1@q.com',
                       password: '12345678', password_confirmation: '12345679', role_id:1, city_id:1)
      expect(u2.valid?).to eq(false)
    end

    it 'invalid user by nonexistent role' do
        u2 = User.create(name: 'Oscar andres', email: 'q1@q.com',
                         password: '12345678', password_confirmation: '12345678', role_id:4, city_id:2)
        expect(u2.valid?).to eq(false)
    end

    it 'invalid user by nonexistent city' do
        u2 = User.create(name: 'Oscar andres', email: 'q1@q.com',
                         password: '12345678', password_confirmation: '12345678', role_id:2, city_id:4)
        expect(u2.valid?).to eq(false)
    end

    it 'invalid user by invalid email' do
        u2 = User.create(name: 'Oscar andres', email: 'asdf',
                         password: '12345678', password_confirmation: '12345678', role_id:1, city_id:1)
        expect(u2.valid?).to eq(false)
    end

    it 'invalid user by short name' do
        u2 = User.create(name: '', email: 'q1@q.com',
                         password: '12345678', password_confirmation: '12345678', role_id:1, city_id:1)
        expect(u2.valid?).to eq(false)
    end
  end
end
