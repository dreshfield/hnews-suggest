class MiniTest::Spec
    before :each do
        DatabaseCleaner.start
    end

    after :each do
        DatabaseCleaner.clean
    end
end
