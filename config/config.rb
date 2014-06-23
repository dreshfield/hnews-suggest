if ENV["APP_ENV"]
    Sequel.connect "sqlite://db/#{ENV["APP_ENV"]}.sqlite3" 
else
    db_file = File.expand_path("~/.hnews/db.sqlite3")

    Sequel.connect "sqlite://#{db_file}"
end
