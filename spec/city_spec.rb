# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  context 'City model creation' do
    let(:c1) { City.new(name: 'Medellín', country_id: 2) }

    it 'valid City' do
      expect(c1.valid?).to eq(true)
    end

    it 'invalid city by existing combination of name and country_id' do
      c2 = City.new(name: 'Bogotá', country_id: 1)
      expect(c2.valid?).to eq(false)
    end

    it 'invalid city by nonexistent country_id' do
      c2 = City.new(name: 'Cartagena', country_id: 10)
      expect(c2.valid?).to eq(false)
    end

    it 'invalid city by short name' do
      c2 = City.new(name: '', country_id: 1)
      expect(c2.valid?).to eq(false)
    end
  end
end
