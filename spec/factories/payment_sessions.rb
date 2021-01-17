FactoryBot.define do
  factory :payment_session do
    user
    item
    state { :created }
    stripe_checkout_session_id { Faker::Crypto.md5 }
    stripe_payment_intent_id { Faker::Crypto.md5 }
    stripe_event_id { Faker::Crypto.md5 }

    trait :paid do
      state { :paid }
    end

    trait :failed do
      state { :failed }
    end

    trait :fulfilled do
      state { :fulfilled }
    end
  end
end
