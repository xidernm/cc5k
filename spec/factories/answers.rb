# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    amount 1.5
    user_id 1
    statistic_id 1
  end
end
