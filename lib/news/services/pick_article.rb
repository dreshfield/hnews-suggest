module News
    class PickArticle
        def initialize opts={}
            @input = opts[:input] || $stdin
            @output = opts[:output] || $stdout
        end

        def start
            @id = @input.gets.chomp
            choose
            render
        end

        private

        def choose
            @article = Article[@id]
        end

        def render
            if @article.nil?
                @output.puts "Please enter an id"
            else
                @output.puts "Picked: #{@article.title}"
            end
        end
    end
end
