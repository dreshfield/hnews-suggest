module HNews
    class SuggestArticle
        attr_reader :article

        def initialize opts={}
            @input = opts[:input] || $stdin
            @output = opts[:output] || $stdout
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
            @article = articles.order(:rank).limit(1).reverse.first

            @output.puts <<EOF
[#{@article.id}] #{@article.title} (#{@article.rank})
    #{@article.url}

EOF
        end

    end
end
