FactoryGirl.define do
  factory :cart_session do
    association :user, factory: :user
    association :cart, factory: :cart
  end
end
