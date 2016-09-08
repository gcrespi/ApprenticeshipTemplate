FactoryGirl.define do
  factory :credit_card do
    owner 'Ayelen Mac Garcia'
    number '4712371231231233'
    expiration_date Date.new(2032, 2)
  end
end