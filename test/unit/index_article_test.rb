require "test_helper"
require "hnews/services/index_article"

module HNews
    class IndexArticleTest < MiniTest::Test

        def setup
            @input = StringIO.new
            @output = StringIO.new
            @article = create(:article_with_content)
        end

        def test_message_output
            service = IndexArticle.new(@article, {input: @input, output: @output})
            service.start

            assert_includes @output.string, "Indexed #{@article.title}"
        end

        def test_service_filters_end_words
            service = IndexArticle.new(@article, {input: @input, output: @output})
            service.start

            content = @article.content
            words = content.split(/\W+/)

            END_WORDS.each do |end_word|
                refute words.include?(end_word), "End word '#{end_word}' found in content"
            end
        end

        def test_service_generates_keywords
            service = IndexArticle.new(@article, {input: @input, output: @output})
            service.start

            keywords = Keyword.all.count
            assert keywords > 0
        end

        def test_existing_keyword_rank_is_increased
            keyword = create(:keyword, {word: 'keyboard', rank: 5})
            service = IndexArticle.new(@article, {input: @input, output: @output})
            service.start

            keyword = Keyword.first(word: 'keyboard')

            assert_equal 6, keyword.rank
        end

        def test_keyword_last_used_time_is_updated
            now = Time.now
            keyword = create(:keyword, {word: 'keyboard', last_used: now})
            service = IndexArticle.new(@article, {input: @input, output: @output})
            service.start

            keyword = Keyword.first(word: 'keyboard')

            refute keyword.last_used == now
        end

        def test_article_title_is_indexed
            article = create(:article, {title: "Ruby programming", content: "this is about ruby", rank: 0})
            service = IndexArticle.new(article, {input: @input, output: @output})
            service.start

            word = Keyword.first(word: "programming")
            refute word.nil?
        end
    end
end
