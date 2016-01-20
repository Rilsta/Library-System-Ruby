require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
require('pg')
require('pry')
also_reload('./lib/**/*.rb')

DB = PG.connect({:dbname => 'library_system'})

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

get('/librarian/book/edit/:id') do
  @book = Book.find(params[:id].to_i())
  @genres = Book.accepted_genres()
  erb(:update_book)
end

post('/librarian/book_list/book_update/:id') do
  @book = Book.find(params[:id].to_i())
  @book.update(params)
  redirect ('/librarian/books')
end

get('/librarian/book/delete/:id') do
  @book = Book.find(params[:id].to_i())
  @book.delete()
  redirect ('/librarian/books')
end

get('/librarian/books/filter') do
  binding.pry
  @filter = Book.filter(params.fetch('filter'))
  binding.pry
end
