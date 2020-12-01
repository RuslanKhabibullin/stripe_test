FactoryBot.define do
  sequence(:email) { Faker::Internet.unique.email }
  sequence(:first_name) { Faker::Name.first_name }
  sequence(:last_name) { Faker::Name.last_name }
end
