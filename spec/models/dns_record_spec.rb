# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  context 'when creating a new record with a valid ip address' do
    it 'then result a valid record' do
      dns_record = create(:dns_record)
      expect(dns_record).to be_valid
    end
  end

  context 'when creating a new record with invalid ip address' do
    it 'then result an model validation error' do
      dns_record = DnsRecord.new
      dns_record.ip_address = '1.a.1.1.1'
      dns_record.valid?
      expect(dns_record.errors[:ip_address]).to include("must be a valid IPv4 address")
    end
  end
end
