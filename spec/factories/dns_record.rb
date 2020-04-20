FactoryBot.define do
  factory :dns_record do
    ip_address { FFaker::Internet.ip_v4_address }
  end
end
