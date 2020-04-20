# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hostname, type: :model do
  context 'when creating a new record' do
    it 'then result a valid record' do
      hostname = create(:hostname)
      expect(hostname).to be_valid
    end
  end
end
