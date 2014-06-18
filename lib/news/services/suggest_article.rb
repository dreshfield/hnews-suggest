module News
    class SuggestArticle
        def initialize opts={}
            @input = opts[:input] || $stdin
            @output = opts[:output] || $stdout

            @suggestions = []
        end

        def start
            get_articles
            calculate_article_rank
            suggest_articles
        end

        private

        def get_articles
            @articles = Article.exclude(title: nil)
        end

        def calculate_article_rank
            @articles.each do |article|
                title_words = article.title.split(/\W+/)
                title_words.map! { |w| Keyword.first(word: w.downcase) }.compact

                title_words.each do |kw|
                    article.rank += kw.rank unless kw.nil?
                end

                article.save
            end
        end

        def suggest_articles
            articles = Article.exclude(rank: nil)
            articles = articles.order(:rank).limit(5)

            articles.each do |a|
                @output.puts "[#{a.id}] #{a.title}"
            end
        end

    end
end
