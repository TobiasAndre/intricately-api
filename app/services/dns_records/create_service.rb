# frozen_string_literal: true

module DnsRecords
  class CreateService
    attr_reader :params

    DnsRecordError = Class.new(StandardError)

    def initialize(params:)
      @params = params
    end

    def call
      dns_record = DnsRecord.new(params)
      dns_record.save!

      dns_record
    rescue ActiveRecord::RecordInvalid => e
      raise DnsRecordError, e
    end
  end
end
