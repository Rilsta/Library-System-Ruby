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
end
