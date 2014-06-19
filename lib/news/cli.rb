module News
    class App < Thor
        desc :learn, "Learn what articles you like"
        def learn
            ingest = Ingest.new
            ingest.start

            list = ListArticles.new
            list.start

            pick = PickArticle.new
            article = pick.start

            index = IndexArticle.new article
            index.start
        end

        desc :suggest, "Suggest an article"
        def suggest
            suggestion = SuggestArticle.new
            suggestion.start
        end
    end
end
