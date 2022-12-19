FactoryBot.define do
  factory :execution do
    user
    task

    before(:create) do |execution|
      execution.user.roles << execution.task.role
    end
  end
end
