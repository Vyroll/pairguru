require 'rails_helper'

FactoryBot.define do
  factory :comment do
    text Faker::Lorem.sentence(2, true)
    user
    movie
  end
end
