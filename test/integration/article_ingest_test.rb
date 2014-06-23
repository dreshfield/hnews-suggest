require "test_helper"
require "hnews/services/ingest"

describe HNews::Ingest do
    before do
        @ingest = HNews::Ingest.new
    end

    it "ingests articles from Hacker News" do
        @ingest.start

        assert_equal 30, @ingest.articles.length
    end
end
