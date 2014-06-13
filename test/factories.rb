require "news/models"
require "helpers/sequel"

FactoryGirl.define do
    factory :keyword

    factory :article do
        url "http://gregchapple.com/programmers-block/"
    end
end
