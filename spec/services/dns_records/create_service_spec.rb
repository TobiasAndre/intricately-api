# frozen_string_literal: true

require "rails_helper"

RSpec.describe DnsRecords::CreateService, type: :service do
  subject(:service) { described_class.new(params: params).call }

  describe "#call" do
    context 'when is called with valid params' do
      let(:params) do
        {
          ip_address: '1.1.1.1',
          hostnames_attributes: [{ name: 'dolor.com' }]
        }
      end
      it 'then create a dns_record / hostname' do
        expect(service).to be_truthy
      end
    end

    context 'when is called with invalid params' do
      let(:params) do
        {
          ip_address: '1.1.1.a',
          hostnames_attributes: [{ name: 'dolor.com' }]
        }
      end
      it 'then raise an error' do
        expect { service }.to raise_error(DnsRecords::CreateService::DnsRecordError)
      end
    end 
  end
end
