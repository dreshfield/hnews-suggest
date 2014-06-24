module HNews
    class App < Thor
        desc :learn, "Learn what articles you like"
        def learn
            ingest = Ingest.new
            ingest.start

            list = ListArticles.new
            list.start

            pick = PickArticle.new
            article = pick.start

            scrape = ScrapeArticle.new article
            scrape.start

            index = IndexArticle.new article
            index.start
        end

        desc :suggest, "Suggest an article and optionally open in your browser"
        option :open, type: :boolean, banner: "Open the suggested article in your browser"
        def suggest
            ingest = Ingest.new
            ingest.start

            suggestion = SuggestArticle.new
            suggestion.start

            if options[:open]
                Launchy.open(suggestion.article.url)
            end

            $stdout.print "Did you like this article? [y/n] "
            answer = $stdin.gets.chomp.downcase

            if answer == "y"
                scrape = ScrapeArticle.new suggestion.article
                scrape.start

                index = IndexArticle.new suggestion.article
                index.start
            elsif answer == "n"
                # todo: perhaps suggest another article here?
            else
                exit
            end

            suggestion.article.read = true
            suggestion.article.save
        end

        desc :version, "Output version info"
        def version
            require "hnews/version"
            puts "hnews-suggest version #{HNews::VERSION}"
        end
    end
end
