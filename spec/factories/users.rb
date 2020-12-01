FactoryBot.define do
  factory :user do
    email
    first_name
    last_name
    password { "123456" }
    password_confirmation { "123456" }
  end
end
