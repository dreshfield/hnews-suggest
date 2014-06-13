Sequel.migration do
    change do
        create_table :keywords do 
            primary_key :id
            String :word
            Integer :rank
            Time :last_used
        end
    end
end
