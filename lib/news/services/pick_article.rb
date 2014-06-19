require "open-uri"

module News
    class PickArticle
        def initialize opts={}
            @input = opts[:input] || $stdin
            @output = opts[:output] || $stdout
        end

        def start
            @id = @input.gets.chomp
            choose

            get_content unless @article.nil?
            render
        end

        private

        def choose
            @article = Article[@id]
        end

        def get_content
            paras = []
            doc = Nokogiri::HTML(open(@article.url))
            doc.css("p").each do |para|
                paras << para.content
            end
            @article.content = paras.join(" ")
            @article.save
        end

        def render
            if @article.nil?
                @output.puts "Please enter an id"
            else
                @output.puts "Picked: #{@article.title}"
            end
            return @article
        end
    end
end
