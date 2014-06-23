require "test_helper"
require "hnews/services/scrape_article"

describe HNews::ScrapeArticle do
    before do
        @article = create(:article)
        @output = StringIO.new
    end

    it "sets the articles content attribute" do
        service = HNews::ScrapeArticle.new @article, input: nil, output: @output
        service.start

        article = Article.first(id: @article.id)

        refute article.content.empty?
    end
end
