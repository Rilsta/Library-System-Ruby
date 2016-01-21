require ('spec_helper')

describe(Book) do
  describe('#id, #author, #genre, #title') do
    it('will return information when inputted') do
      books = Book.new({id: nil,
                        author: 'Mark Twain',
                        genre: 'Historical Fiction',
                        title: 'Tom Sawyer'})
      expect(books.id()).to(eq(nil))
      expect(books.author()).to(eq('Mark Twain'))
      expect(books.genre()).to(eq('Historical Fiction'))
      expect(books.title()).to(eq('Tom Sawyer'))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves input from database and stores to an array') do
      test_book = create_test_book
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('#update') do
    it('updates input from database and stores to an array') do
      test_book = create_test_book
      test_book.save()
      test_book.update({"author" => 'Mark Hammil', "title" => 'Teeth', "genre" => 'Non-Fiction'})
      expect(test_book.author).to eq('Mark Hammil')
      expect(test_book.title).to eq('Teeth')
      expect(test_book.genre).to eq('Non-Fiction')
    end
  end

  describe('#delete') do
    it('deletes information from database') do
      test_book = create_test_book
      test_book.save
      test_book2 = create_test_book_2
      test_book2.save
      test_book.delete
      expect(Book.all()).to(eq([test_book2]))
    end
  end

  describe("#==") do
    it("is the same book if it has the same information") do
      book1 = create_test_book
      book2 = create_test_book
      expect(book1).to(eq(book2))
    end
  end

  describe('.filter') do
    it('filters based on user preference') do
      book1 = create_test_book
      book1.save
      book2 = create_test_book_2
      book2.save
      expect(Book.filter('Fiction')).to(eq([book2]))
    end
  end
end
