require "test_helper"
require "hnews/services/ingest"

describe HNews::Ingest do
    before do
        @ingest = HNews::Ingest.new
    end

    it "ingests articles from Hacker News" do
        @ingest.start

        @ingest.articles.length.must_equal 30
    end
end
