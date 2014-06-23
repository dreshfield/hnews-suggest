require "test_helper"
require "hnews/services/suggest_article"

describe HNews::IndexArticle do
    it "suggests an article" do
        create(:keyword, {word: 'software', rank: 5})
        create(:keyword, {word: 'keyboard', rank: 2})
        create(:keyword, {word: 'development', rank: 6})

        create(:article_with_content)
        article = create(:article, {title: 'On Software Development', rank: 0})

        output = StringIO.new
        service = HNews::SuggestArticle.new input: nil, output: output
        service.start

        output.string.must_include "[#{article.id}] On Software Development"
        output.string.must_include article.url
    end

    it "sets the articles rank" do
        create(:keyword, {word: 'software', rank: 5})
        create(:keyword, {word: 'keyboard', rank: 2})
        create(:keyword, {word: 'development', rank: 6})

        create(:article_with_content)
        article = create(:article, {title: 'On Software Development', rank: 0})

        output = StringIO.new
        service = HNews::SuggestArticle.new input: nil, output: output
        service.start

        article = Article.first(id: article.id)

        article.rank.must_be :>, 0
    end

    it "doesn't constantly increase articles rank" do
        create(:keyword, {word: 'software', rank: 5})
        create(:keyword, {word: 'keyboard', rank: 2})
        create(:keyword, {word: 'development', rank: 6})

        create(:article_with_content)
        article = create(:article, {title: 'On Software Development', rank: 0})

        output = StringIO.new
        service = HNews::SuggestArticle.new input: nil, output: output

        # run the service twice
        service.start
        service.start

        article = Article.first(id: article.id)

        article.rank.must_equal 11
    end
end
