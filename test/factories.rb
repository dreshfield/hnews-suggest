require "news/models"

FactoryGirl.define do
    factory :keyword

    factory :article do
        url "http://gregchapple.com/programmers-block/"
    end
end
