# frozen_string_literal: true

class DnsRecordsController < ApplicationController
  def index
    return page_missing? if empty_page?

    dns_records = DnsRecord.all.includes(:hostnames)
    paginate dns_records, per_page: 15
  rescue StandardError => e
    render status: :internal_server_error, json: { message: e.message }
  end

  def create
    return params_missing? if empty_params?

    dns_record = DnsRecords::CreateService.new(params: dns_hostname_params).call

    render json: { id: dns_record.id }
  rescue DnsRecords::CreateService::DnsRecordError => e
    render status: :unprocessable_entity, json: { message: e.message }
  rescue StandardError => e
    render status: :internal_server_error, json: { message: e.message }
  end

  private

  def empty_page?
    params[:page].blank?
  end

  def page_missing?
    render json: { message: "Page number parameter is required" }, status: :unprocessable_entity
  end

  def empty_params?
    params[:dns_record].blank?
  end

  def params_missing?
    render json: { message: "all parameters are required" }, status: :unprocessable_entity
  end

  def dns_hostname_params
    params.require(:dns_record).permit(
      :ip_address,
      hostnames_attributes: %i[id name]
    )
  end
end
