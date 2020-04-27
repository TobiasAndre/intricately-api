# frozen_string_literal: true

class DnsRecordSerializer < ActiveModel::Serializer
  attributes :id, :ip_address
  has_many :hostnames
end
