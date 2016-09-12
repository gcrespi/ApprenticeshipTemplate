FactoryGirl.define do
  factory :credit_card do
    owner 'Ayelen Mac Garcia'
    number '4712371231231233'
    expiration_date 3.months.from_now
  end
end