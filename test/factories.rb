require "news/models"
require "helpers/sequel"
require "helpers/database_cleaner"

FactoryGirl.define do
    factory :keyword

    factory :article do
        title "Programmers block"
        url "http://gregchapple.com/programmers-block/"
    end
end
