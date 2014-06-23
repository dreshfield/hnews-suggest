ENV["APP_ENV"] = "test"

require "sequel"
require "factory_girl"
require "database_cleaner"
require "config"
require "factories"

require "minitest"
require "minitest/autorun"


DatabaseCleaner.strategy = :transaction
class MiniTest::Spec
    before :each do
        DatabaseCleaner.start
    end

    after :each do
        DatabaseCleaner.clean
    end
end

class MiniTest::Spec
    include FactoryGirl::Syntax::Methods
end
