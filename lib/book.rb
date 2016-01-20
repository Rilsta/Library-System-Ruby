class Book
  attr_reader(:id, :author, :genre, :title)
  @@genres = ['Non-Fiction', 'Fiction']

  def initialize(attribute)
    @id = attribute.fetch(:id)
    @genre = attribute.fetch(:genre)
    @author = attribute.fetch(:author)
    @title = attribute.fetch(:title)
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    Book.map_results_to_objects(returned_books)
  end

  def save
    saved_book = DB.exec("INSERT INTO books (genre, author, title) \
      VALUES ('#{@genre}', '#{@author}', '#{@title}') RETURNING id;")
      @id = saved_book.first.fetch("id").to_i()
  end

  def self.filter(column, filter)
    returned_books = DB.exec("SELECT * FROM books WHERE #{column} LIKE '#{filter}';")
    Book.map_results_to_objects(returned_books)
  end

  def self.find(id)
    books = Book.all
    books.each do |book|
      return book if book.id == id
    end
    book = nil
  end

  def self.map_results_to_objects(returned_books)
    books = []
    returned_books.each() do |book|
      books << Book.new({
        :id => book.fetch('id').to_i(),
        :genre => book.fetch('genre'),
        :author => book.fetch('author'),
        :title => book.fetch('title')
        })
    end
    books
  end

  def self.accepted_genres
    @@genres
  end

  def ==(another_book)
    self.genre == (another_book.genre()) &&
    self.author == (another_book.author()) &&
    self.title == (another_book.title()) &&
    self.id == (another_book.id())
  end
end
