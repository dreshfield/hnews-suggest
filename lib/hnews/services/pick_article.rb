module HNews
    class PickArticle
        attr_reader :article

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
                @output.puts "Not a valid id"
                return false
            else
                @output.puts "Picked: #{@article.title}"
                return true
            end
        end
    end
end
