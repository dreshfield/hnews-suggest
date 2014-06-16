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

    end
end
