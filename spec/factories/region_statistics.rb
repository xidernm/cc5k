# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :region_statistic do
    region_id 1
    amount 1.5
    stat_type "MyString"
  end
end
