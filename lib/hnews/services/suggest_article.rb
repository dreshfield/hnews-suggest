module HNews
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
            @articles = Article.where(read: nil).exclude(title: nil)
        end

        def calculate_article_rank
            @articles.each do |article|
                title_words = article.title.split(/\W+/)
                title_words.map! { |w| Keyword.first(word: w.downcase) }.compact

                article.rank = 0
                title_words.each do |kw|
                    article.rank += kw.rank unless kw.nil?
                end

                article.save
            end
        end

        def suggest_articles
            articles = Article.where(read: nil).exclude(rank: nil)
            articles = articles.order(:rank).limit(5).reverse

            articles.each do |a|
                @output.puts <<EOF
[#{a.id}] #{a.title} (#{a.rank})
    #{a.url}

EOF
            end
        end

    end
end
