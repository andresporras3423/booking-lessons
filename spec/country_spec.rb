require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'Country model creation' do
    let(:c1) { Country.new(name: 'Spain', cod: 'SPA') }
    before(:each) do
      c1.save
    end
    it 'valid Country' do
      expect(c1.valid?).to eq(true)
    end

    it 'invalid country by existing name' do
      c2 = Country.new(name: 'Colombia', cod: 'CL')
      expect(c2.valid?).to eq(false)
    end

    it 'invalid country by existing cod' do
        c2 = Country.new(name: 'Columbia', cod: 'COL')
        expect(c2.valid?).to eq(false)
      end

    it 'invalid country by short name' do
        c2 = Country.new(name: '', cod: 'CL')
      expect(c2.valid?).to eq(false)
    end

    it 'invalid country by short cod' do
        c2 = Country.new(name: 'Columbia', cod: '')
      expect(c2.valid?).to eq(false)
    end
  end
end