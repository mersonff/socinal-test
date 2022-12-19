FactoryBot.define do
  factory :user do
    sequence(:nickname) { "john_doe_#{_1}" }
  end
end
