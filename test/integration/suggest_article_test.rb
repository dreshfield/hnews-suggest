require "test_helper"
require "news/services/suggest_article"

module News
    class IndexArticleTest < MiniTest::Test

        def test_service_suggests_an_article
            create(:keyword, {word: 'software', rank: 5})
            create(:keyword, {word: 'keyboard', rank: 2})
            create(:keyword, {word: 'development', rank: 6})

            create(:article_with_content)
            article = create(:article, {title: 'On Software Development', rank: 0})

            output = StringIO.new
            service = SuggestArticle.new input: nil, output: output
            service.start

            assert_includes output.string, "[#{article.id}] On Software Development"
        end
    end
end
