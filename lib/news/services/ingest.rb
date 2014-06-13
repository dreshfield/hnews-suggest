require "nokogiri"
require "open-uri"

module News
    class Ingest
        attr_reader :articles

        def initialize
            @articles = []
        end

        def start
            scan_page
            get_links
            generate_articles
        end

        private

        def scan_page
            page = open("https://news.ycombinator.com")
            @doc = Nokogiri::HTML(page)
        end

        def get_links
            @links = @doc.css("td.title").select { |td| links td }
            @links = @links.map { |i| i.at("a") }
        end

        def generate_articles
            @links.each do |link|
                @articles << create_article(link.content, link[:href])
            end
        end

        def create_article title, url
            Article.new title: title, url: url
        end

        def links td
            td[:align] != "right" && td.at("a")[:href] != "news2"
        end
    end
end
