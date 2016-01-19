FactoryGirl.define do
  factory :entry do
    user
    date { Date.today }
    hours 1
    note 'Worked a lot'
  end
end
