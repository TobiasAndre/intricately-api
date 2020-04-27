# frozen_string_literal: true

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

  # #
  # The query below returns the DNS records
  # that include precisely hostnames passed in the parameter named "included"
  # removing records that contain hostnames passed in the parameter named "excluded."
  #
  scope :filter_hostnames, (lambda { |included_names, excluded_names|
    included_hostnames = Arel::Table.new("included_hostnames")
    DnsRecord.select([:id, :ip_address]).from(
      DnsRecord.select([Arel.star.count.as("regs"), DnsRecord.arel_table[:id], :ip_address]).where(
        Hostname.arel_table[:name].in(included_names)
      ).joins(
        DnsRecord.arel_table.join(DnsRecordsHostname.arel_table).on(
          DnsRecordsHostname.arel_table[:dns_record_id].eq(DnsRecord.arel_table[:id])
        ).join_sources
      ).joins(
        DnsRecord.arel_table.join(Hostname.arel_table).on(
          Hostname.arel_table[:id].eq(DnsRecordsHostname.arel_table[:hostname_id])
        ).join_sources
      ).group(:ip_address, DnsRecord.arel_table[:id]).as("included_hostnames")
    ).where(included_hostnames[:regs].eq(included_names.count)
     .and(included_hostnames[:ip_address].not_in(
            DnsRecord.select(:ip_address).where(Hostname.arel_table[:name].in(excluded_names)).joins(
              DnsRecord.arel_table.join(DnsRecordsHostname.arel_table).on(
                DnsRecordsHostname.arel_table[:dns_record_id].eq(DnsRecord.arel_table[:id])
              ).join_sources
            ).joins(
              DnsRecord.arel_table.join(Hostname.arel_table).on(
                Hostname.arel_table[:id].eq(DnsRecordsHostname.arel_table[:hostname_id])
              ).join_sources
            ).pluck(:ip_address)
          )))
  })
end
