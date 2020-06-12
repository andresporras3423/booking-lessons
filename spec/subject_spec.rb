# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject, type: :model do
  context 'Subject model creation' do
    let(:s1) { Subject.new(name: 'programming') }
    it 'valid Subject' do
      expect(s1.valid?).to eq(true)
    end

    it 'invalid Subject by existing name' do
      s2 = Subject.new(name: 'spanish')
      expect(s2.valid?).to eq(false)
    end

    it 'invalid Subject by short name' do
      s2 = Subject.new(name: '')
      expect(s2.valid?).to eq(false)
    end
  end
end
