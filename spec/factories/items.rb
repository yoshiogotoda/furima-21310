FactoryBot.define do
  factory :item do
    name                     {Faker::Name.initials(number: 6)}
    explain                  {Faker::Lorem.paragraph(sentence_count: 3)}
    category_id              {Faker::Number.rand(1..10)}
    sales_status_id          {Faker::Number.rand(1..6)}
    shopping_fee_status_id   {Faker::Number.rand(1..2)}
    prefecture_id            {Faker::Number.rand(1..47)}
    scheduled_delivery_id    {Faker::Number.rand(1..3)}
    price                    {Faker::Number.rand(300..9999999)}
    id                       { 1 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end
