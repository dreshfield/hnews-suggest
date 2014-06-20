module HNews
    class ListArticles
        def initialize options={}
            @input = options[:input] || $stdin
            @output = options[:output] || $stdout
        end

        def start
            get_articles
            display_articles
        end

        private

        def get_articles
            @articles = Article.where(read: nil).limit(30)
        end

        def display_articles
            @articles.each do |article|
                @output.puts "[#{article.id}] #{article.title}"
            end
        end
    end
end
