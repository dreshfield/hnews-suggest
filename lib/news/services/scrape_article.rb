require "open-uri"

module News
    class ScrapeArticle
        def initialize article, opts={}
            @input = opts[:input] || $stdin
            @output = opts[:output] || $stdout
            @article = article
        end

        def start
            get_content
        end

        private

        def get_content
            paras = []
            doc = Nokogiri::HTML(open(@article.url))
            doc.css("p").each do |para|
                paras << para.content
            end
            @article.content = paras.join(" ")
            @article.save
        end

    end
end
