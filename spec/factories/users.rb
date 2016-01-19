FactoryGirl.define do
  factory :user do
    sequence(:email)   { |n| "foo_#{n}@bar.com" }
    password 'foobar'
  end
end
