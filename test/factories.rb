require "hnews/models"
require "hnews/models/article"
require "helpers/sequel"

FactoryGirl.define do
    factory :keyword do
        rank 0
        last_used Time.now
    end

    factory :article do
        title "Programmers block"
        url "http://gregchapple.com/programmers-block/"
        content "Your fingers sit idly on your keyboard, eagerly awaiting the signal from your brain to produce this masterpiece of software. Nothing."
    end

    factory :article_with_content, class: Article do
        title "Programmers block"
        url "http://gregchapple.com/programmers-block/"
        content "Your fingers sit idly on your keyboard, eagerly awaiting the signal from your brain to produce this masterpiece of software. Nothing."
    end
end
