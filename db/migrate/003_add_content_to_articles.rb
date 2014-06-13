Sequel.migration do
    change do
        add_column :articles, :content, String
    end
end
