require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/patron')
require('./lib/checkout')
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

get('/librarian/checked_out_books') do
  @checkout_list = Checkout.checked_out_books
  erb(:checkout_list)
end

get('/librarian/books/filter') do
  @books = Book.filter(params.fetch('filter'))
  erb(:book_list)
end

#######################

get('/librarian/add_patron') do
  erb(:patron_form)
end

post('/librarian/add_patron/new') do
  book = Patron.new({:id => nil,
                   :name => params.fetch('name')}).save()

  redirect ('/librarian/patrons')
end

get('/librarian/patrons') do
  @patrons = Patron.all()
  erb(:patron_list)
end

get('/librarian/patron/:id') do
  @patron = Patron.find(params[:id].to_i())
  erb(:patron)
end

get('/librarian/patron/edit/:id') do
  @patron = Patron.find(params[:id].to_i())
  erb(:update_patron)
end

post('/librarian/patron_list/patron_update/:id') do
  @patron = Patron.find(params[:id].to_i())
  @patron.update(params)
  redirect ('/librarian/patrons')
end

get('/librarian/patron/delete/:id') do
  @patron = Patron.find(params[:id].to_i())
  @patron.delete()
  redirect ('/librarian/patrons')
end

get('/librarian/patrons/filter') do
  @patrons = Patron.filter(params.fetch('filter'))
  erb(:patron_list)
end

######################

get('/sign_in') do
  erb(:patron_sign_in)
end

get('/patron') do
  if Patron.find(params.fetch("id_number").to_i)
    redirect("patron/#{params.fetch("id_number").to_i}/welcome")
  else
    redirect ('sign_in')
  end
end

get('/patron/:patron_id/welcome') do
  @patron = Patron.find(params.fetch("patron_id").to_i)
  @books = Book.all
  erb(:patron_books)
end

get('/patron/:patron_id/book/checkout/:book_id') do
  book = Checkout.new({:id => nil,
                   :patron_id => params.fetch("patron_id").to_i,
                   :book_id => params.fetch("book_id").to_i}).save()

  redirect ("/patron/#{params.fetch("patron_id").to_i}/welcome")
end

get('/patron/:patron_id/book/checkin/:book_id') do
  checkout = Checkout.retrieve_by_book(params.fetch("book_id").to_i)
  checkout.delete
  redirect ("/patron/#{params.fetch("patron_id").to_i}/welcome")
end
