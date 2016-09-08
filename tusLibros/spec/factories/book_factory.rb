FactoryGirl.define do
  factory :a_book, class: :Book do
    isbn '9788427811362'
    price  20
  end

  factory :another_book, class: :Book do
    isbn '9781235152362'
    price  35
  end
end