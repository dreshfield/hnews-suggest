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
            assert_includes output.string, article.url
        end

        def test_service_sets_article_rank
            create(:keyword, {word: 'software', rank: 5})
            create(:keyword, {word: 'keyboard', rank: 2})
            create(:keyword, {word: 'development', rank: 6})

            create(:article_with_content)
            article = create(:article, {title: 'On Software Development', rank: 0})

            output = StringIO.new
            service = SuggestArticle.new input: nil, output: output
            service.start

            article = Article.first(id: article.id)

            refute article.rank.zero?
        end

        def test_service_doesnt_continuously_increase_rank
            create(:keyword, {word: 'software', rank: 5})
            create(:keyword, {word: 'keyboard', rank: 2})
            create(:keyword, {word: 'development', rank: 6})

            create(:article_with_content)
            article = create(:article, {title: 'On Software Development', rank: 0})

            output = StringIO.new
            service = SuggestArticle.new input: nil, output: output

            # run the service twice
            service.start
            service.start

            article = Article.first(id: article.id)

            assert_equal article.rank, 11
        end
    end
end
