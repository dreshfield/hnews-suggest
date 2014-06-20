require "test_helper"
require "hnews/services/scrape_article"

module HNews
    class ScrapeArticleTest < MiniTest::Test
        def setup
            @article = create(:article)
            @output = StringIO.new
        end

        def test_article_content_is_set
            service = ScrapeArticle.new @article, input: nil, output: @output
            service.start

            article = Article.first(id: @article.id)

            refute article.content.empty?
        end
    end
end
