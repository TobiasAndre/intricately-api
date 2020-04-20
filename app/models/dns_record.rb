class DnsRecord < ApplicationRecord
  has_and_belongs_to_many :hostnames
  accepts_nested_attributes_for :hostnames
  validates :ip_address,
            presence: true,
            uniqueness: true,
            format: {
              with: /^((?:(?:^|\.)(?:\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){4})$/,
              message: "must be a valid IPv4 address",
              multiline: true
            }
end
