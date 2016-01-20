require('rspec')
require('pg')
require('patron')
require('book')

DB = PG.connect({:dbname => 'library_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    # DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM books *;")
  end
end

def create_test_book
  Book.new({
    :id => nil,
    :genre => "Historical",
    :author => "Joe Blow",
    :title => "Joes history of Portland",
    })
end

def create_test_book_2
  Book.new({
    :id => nil,
    :genre => "Fiction",
    :author => "Sheldon Cooper",
    :title => "Why Im so smart",
    })
end
