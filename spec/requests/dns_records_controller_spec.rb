  
# frozen_string_literal: true

require "rails_helper"

RSpec.describe DnsRecordsController, type: :request do
  describe "POST #create" do
    let(:new_dns_record1) {create(ip_address: "8.8.8.8")}

    let(:hostname1) {create(name: 'abram.com')}
    let(:hostname2) {create(name: 'amend.com')}
    let(:hostname3) {create(name: 'amenus.com')}
    let(:hostname4) {create(name: 'loki.com')}
    let(:hostname5) {create(name: 'joker.com')}

    let(:dns_records_hostname1){create(dns_record: new_dns_record1,hostname: hostname1)}
    let(:dns_records_hostname2){create(dns_record: new_dns_record1,hostname: hostname2)}
    let(:dns_records_hostname3){create(dns_record: new_dns_record1,hostname: hostname3)}
    let(:dns_records_hostname4){create(dns_record: new_dns_record1,hostname: hostname4)}

    context "when params is missing" do
      it "return unprocessable entity (422)" do
        post "/dns_records", params: {}
        expect(response).to have_http_status(422)
      end
    end

    context "when an invalid dns parameter is present" do
      let(:params) do
        {
          dns_record: {
            ip_address: '1.1.1.a',
            hostnames_attributes: [{ name: 'dolor.com' }]
          }
        }
      end
      it "returns DnsRecordError" do
        post "/dns_records", params: params
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
        expect(response).to have_http_status(201)
      end
    end 
  end

  describe "GET #index" do
    context "when page parameter is missing" do
      it "return unprocessable entity (422)" do
        get "/dns_records", params: {}
        expect(response).to have_http_status(422)
      end
    end

    context "when page number parameter is present" do
      it "return sucess (200)" do
        get "/dns_records", params: { page: 1 }
        expect(response).to have_http_status(200)
      end
    end

    context "when included and excluded parameters are present" do
      let(:params) do
        {
          included:'abram.com,amend.com',
          excluded:'joker.com',
          page: 1
        }
      end
      it "return an filtered result" do
        get "/dns_records", params: params
        expect(response).to have_http_status(200)
      end
    end

    context "when value for included params is present but excluded parameter is blank" do
      let(:params) do
        {
          included:'abram.com,amend.com',
          excluded: '',
          page: 1
        }
      end
      it "return an filtered result" do
        get "/dns_records", params: params
        expect(response).to have_http_status(200)
      end
    end

    context "when and invalid value is passed in excluded parameter" do
      let(:params) do
        {
          included:'abram.com,amend.com',
          excluded: [],
          page: 1
        }
      end
      it "return an error" do
        get "/dns_records", params: params
        expect(response).to have_http_status(500)
      end
    end
  end
end
