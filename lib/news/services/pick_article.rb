module News
    class PickArticle
        def initialize opts={}
            @input = opts[:input] || $stdin
            @output = opts[:output] || $stdout
        end

        def start
            @output.print "Please enter an id:"
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
            return @article
        end
    end
end
