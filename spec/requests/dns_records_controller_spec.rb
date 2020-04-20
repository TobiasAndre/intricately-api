  
# frozen_string_literal: true

require "rails_helper"

RSpec.describe DnsRecordsController, type: :request do
  describe "POST #create" do
    context "when params is missing" do
      it "return unprocessable entity (422)" do
        post "/dns_records", params: {}
        expect(response).to have_http_status(422)
      end
    end

    context "when request with valid params" do
      let(:params) do
        {
          dns_record: {
            ip_address: '1.1.1.1',
            hostnames_attributes: [{ name: 'dolor.com' }]
          }
        }
      end
      it "return valid quote and status 200" do
        post "/dns_records", params: params
        expect(response).to have_http_status(200)
      end
    end 
  end
end
