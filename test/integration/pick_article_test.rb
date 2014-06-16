require "test_helper"
require "news/services/pick_article"

module News
    class PickArticleText < MiniTest::Test

        def setup
            @article = create(:article, {title: "Programmers block"})
            @output = StringIO.new
        end

        def test_article_can_be_chosen
            input = StringIO.new("#{@article.id}\n")

            service = PickArticle.new input: input, output: @output
            service.start

            assert_includes @output.string, "Picked: Programmers block"
        end

        def test_id_is_nil
            input = StringIO.new("\n")

            service = PickArticle.new input: input, output: @output
            service.start

            assert_includes @output.string, "Please enter an id"
        end

        def test_id_not_found
            input = StringIO.new("99999\n")

            service = PickArticle.new input: input, output: @output
            service.start

            assert_includes @output.string, "Please enter an id"
        end
    end
end
