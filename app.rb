require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
require('pg')
also_reload('./lib/**/*.rb')

DB = PG.connect({:dbname => 'library_system_test'})

get('/') do
  erb(:index)
end

get('/librarian') do
  erb(:librarian)
end

get('/librarian/add_book') do
  @genres = Book.accepted_genres()
  erb(:book_form)
end

post('/librarian/add_book/new') do
  book = Book.new({:id => nil,
                   :genre => params.fetch('genre'),
                   :author => params.fetch('author'),
                   :title => params.fetch('title')}).save()

  redirect ('/librarian/books')
end

get('/librarian/books') do
  @books = Book.all()
  erb(:book_list)
end

get('/librarian/book/:id') do
  @book = Book.find(params[:id].to_i())
  erb(:book)
end
