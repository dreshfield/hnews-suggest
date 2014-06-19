module News

    END_WORDS = %w(a in is as an if the at of on or i are you re one s ok to too all and that ve so yet be do it for now with me)

    class IndexArticle
        def initialize article, opts={}
            @article = article
            @input = opts[:input] || $stdin
            @output = opts[:output] || $stdout
        end

        def start
            index :title
            index :content
        end

        private

        def index key
            filter_end_words @article[key]
            generate_keywords
            save key
            render
        end

        def filter_end_words str
            words = str.split(/\W+/)
            words = words.map{ |word| word.downcase }
            @words = words.select { |word| word unless END_WORDS.include? word }
            @content = @words.join(" ")
        end

        def generate_keywords
            @words.each do |word|
                keyword = Keyword.first(word: word)
                if keyword.nil?
                    keyword = Keyword.new(word: word, rank: 1)
                else
                    keyword.rank += 1
                end
                keyword.last_used = Time.now
                keyword.save
            end
        end

        def save key
            @article[key] = @content
            @article.save
        end

        def render
            @output.puts "Indexed #{@article.title}"
        end
    end
end
