Sequel.migration do
    change do
        create_table :articles do 
            primary_key :id
            String :title
            String :url
            Boolean :read
            Integer :rank
        end
    end
end
