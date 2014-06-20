require "test_helper"
require "news/services/ingest"

module News
    class ArticleIngestTest < MiniTest::Test
        def setup
            @ingest = Ingest.new
        end

        def test_ingests_articles_from_hn
            @ingest.start

            assert_equal 30, @ingest.articles.length
        end

    end
end
