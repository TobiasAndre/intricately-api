FactoryBot.define do
  factory :hostname do
    name { FFaker::Internet.domain_name }
  end
end
