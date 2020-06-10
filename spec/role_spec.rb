# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'role model creation' do
    let(:r1) { Role.new(name: 'manager') }
    it 'valid role' do
      expect(r1.valid?).to eq(true)
    end

    it 'invalid role by existing role name' do
      r2 = Role.new(name: 'student')
      expect(r2.valid?).to eq(false)
    end

    it 'invalid role by short name' do
      r2 = Role.new(name: '')
      expect(r2.valid?).to eq(false)
    end
  end
end
