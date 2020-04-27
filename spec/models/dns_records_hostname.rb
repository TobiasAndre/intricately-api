# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DnsRecordsHostname, type: :model do
  context 'when creating a new record with dns and hostname' do
    it 'then result a valid record' do
      dns_records_hostname = create(:dns_records_hostname)
      expect(dns_records_hostname).to be_valid
    end
  end
end
