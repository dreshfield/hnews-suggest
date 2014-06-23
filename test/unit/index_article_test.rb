require "test_helper"
require "hnews/services/index_article"

describe HNews::IndexArticle do
    before do
        @input = StringIO.new
        @output = StringIO.new
        @article = create(:article_with_content)
    end

    it "outputs the correct message" do
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        @output.string.must_include "Indexed #{@article.title}"
    end

    it "filters out end words" do
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        content = @article.content
        words = content.split(/\W+/)

        HNews::END_WORDS.each do |end_word|
            words.wont_include end_word
        end
    end

    it "generates keywords" do
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        Keyword.all.count.must_be :>, 0
    end

    it "increases the keyword rank" do
        keyword = create(:keyword, {word: 'keyboard', rank: 5})
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        keyword = Keyword.first(word: 'keyboard')

        keyword.rank.must_equal 6
    end

    it "update the last_used attribute on the keywords" do
        now = Time.now
        keyword = create(:keyword, {word: 'keyboard', last_used: now})
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        keyword = Keyword.first(word: 'keyboard')

        keyword.last_used.wont_equal now
    end

    it "indexes the articles title" do
        article = create(:article, {title: "Ruby programming", content: "this is about ruby", rank: 0})
        service = HNews::IndexArticle.new(article, {input: @input, output: @output})
        service.start

        word = Keyword.first(word: "programming")
        word.wont_be_nil
    end
end
