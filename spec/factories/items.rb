FactoryBot.define do
  factory :item do
    name        Faker::Hipster.word
    description Faker::Lorem.sentence
  end
end