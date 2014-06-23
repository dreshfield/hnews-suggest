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

        assert_includes @output.string, "Indexed #{@article.title}"
    end

    it "filters out end words" do
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        content = @article.content
        words = content.split(/\W+/)

        HNews::END_WORDS.each do |end_word|
            refute words.include?(end_word), "End word '#{end_word}' found in content"
        end
    end

    it "generates keywords" do
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        keywords = Keyword.all.count
        assert keywords > 0
    end

    it "increases the keyword rank" do
        keyword = create(:keyword, {word: 'keyboard', rank: 5})
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        keyword = Keyword.first(word: 'keyboard')

        assert_equal keyword.rank, 6
    end

    it "update the last_used attribute on the keywords" do
        now = Time.now
        keyword = create(:keyword, {word: 'keyboard', last_used: now})
        service = HNews::IndexArticle.new(@article, {input: @input, output: @output})
        service.start

        keyword = Keyword.first(word: 'keyboard')

        refute keyword.last_used == now
    end

    it "indexes the articles title" do
        article = create(:article, {title: "Ruby programming", content: "this is about ruby", rank: 0})
        service = HNews::IndexArticle.new(article, {input: @input, output: @output})
        service.start

        word = Keyword.first(word: "programming")
        refute word.nil?
    end
end
