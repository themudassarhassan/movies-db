# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    release_date { Faker::Movies::Avatar.date }
    overview { Faker::Lorem.sentence }
    poster_path { '/some-img.png' }
  end
end
