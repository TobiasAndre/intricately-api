# frozen_string_literal: true

class HostnameSerializer < ActiveModel::Serializer
  attributes :name, :count

  belongs_to :dns_record

  def count
    Hostname.where(name: object.name).count
  end
end
