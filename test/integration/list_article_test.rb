require "test_helper"
require "news/services/list_articles"

module News
    class ListArticlesTest < MiniTest::Test
        def test_articles_are_listed
            article = create(:article, {title: "Programmers block", url: "http://gregchapple.com/programmers-block" })

            output = StringIO.new
            service = ListArticles.new input: nil, output: output
            service.start

            assert_includes output.string, "[#{article.id}] Programmers block"
        end

        def test_thirty_articles_are_listed
            35.times do |i|
                create(:article)
            end

            output = StringIO.new
            service = ListArticles.new input: nil, output: output
            service.start

            articles = output.string.split("\n")

            assert_equal 30, articles.length
        end
    end
end
