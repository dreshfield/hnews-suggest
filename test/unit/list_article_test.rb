require "test_helper"
require "hnews/services/list_articles"

describe HNews::ListArticles do
    it "lists articles" do
        article = create(:article, {title: "Programmers block", url: "http://gregchapple.com/programmers-block" })

        output = StringIO.new
        service = HNews::ListArticles.new input: nil, output: output
        service.start

        assert_includes output.string, "[#{article.id}] Programmers block"
    end

    it "lists thirty articles" do
        35.times do |i|
            create(:article)
        end

        output = StringIO.new
        service = HNews::ListArticles.new input: nil, output: output
        service.start

        articles = output.string.split("\n")

        assert_equal 30, articles.length
    end
end
