# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mission do
    name "MyString"
    description "MyText"
    value 1
    user_id 1
  end
end
