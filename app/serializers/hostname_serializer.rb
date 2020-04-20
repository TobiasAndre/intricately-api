# frozen_string_literal: true

class HostnameSerializer < ActiveModel::Serializer
  attributes :name

  belongs_to :dns_record
end
