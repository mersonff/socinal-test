FactoryBot.define do
  factory :role do
    sequence(:name) { "document.edit.#{_1}" }
  end
end
