FactoryBot.define do
    factory :schedule, class: Schedule do
      user
      room
      scheduled_at { "2022-07-21, 9:00 am" }
    end
  end
  