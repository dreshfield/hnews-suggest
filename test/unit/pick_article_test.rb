require "test_helper"
require "hnews/services/pick_article"

describe HNews::PickArticle do
    before do
        @article = create(:article)
        @output = StringIO.new
    end

    it "allows an id to be entered" do
        input = StringIO.new("#{@article.id}\n")

        service = HNews::PickArticle.new input: input, output: @output
        service.start

        assert_includes @output.string, "Please enter an id:"
    end

    it "allows an article to be chosen" do
        input = StringIO.new("#{@article.id}\n")

        service = HNews::PickArticle.new input: input, output: @output
        service.start

        assert_includes @output.string, "Picked: Programmers block"
    end

    it "id can't be nil" do
        input = StringIO.new("\n")

        service = HNews::PickArticle.new input: input, output: @output
        service.start

        assert_includes @output.string, "Please enter an id"
    end

    it "fails if id is not found" do
        input = StringIO.new("99999\n")

        service = HNews::PickArticle.new input: input, output: @output
        service.start

        assert_includes @output.string, "Please enter an id"
    end

    it "returns an article" do
        input = StringIO.new("#{@article.id}\n")

        service = HNews::PickArticle.new input: input, output: @output
        article = service.start

        assert_equal @article.id, article.id
    end
end
