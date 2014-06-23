require "test_helper"
require "hnews/services/list_articles"

describe HNews::ListArticles do
    it "lists articles" do
        article = create(:article, {title: "Programmers block", url: "http://gregchapple.com/programmers-block" })

        output = StringIO.new
        service = HNews::ListArticles.new input: nil, output: output
        service.start

        output.string.must_include "[#{article.id}] Programmers block"
    end

    it "lists thirty articles" do
        35.times do |i|
            create(:article)
        end

        output = StringIO.new
        service = HNews::ListArticles.new input: nil, output: output
        service.start

        articles = output.string.split("\n")

        articles.length.must_equal 30
    end
end
