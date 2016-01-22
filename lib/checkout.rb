class Checkout
  attr_reader(:id, :patron_id, :book_id)

  def initialize(attribute)
    @id = attribute.fetch(:id)
    @patron_id = attribute.fetch(:patron_id)
    @book_id = attribute.fetch(:book_id)
  end

  def self.all
    returned_checkouts = DB.exec("SELECT * FROM checkouts;")
    Checkout.map_results_to_objects(returned_checkouts)
  end

  def self.checked_out_books
    test_checkouts = DB.exec("SELECT * FROM checkouts, books, patrons WHERE \
      checkouts.book_id = books.id AND checkouts.patron_id = patrons.id;")
    checkout_list = []
    test_checkouts.each do |test_checkout|
      checkout_list << test_checkout
    end
    return checkout_list
  end

  def save
    saved_checkout = DB.exec("INSERT INTO checkouts (patron_id, book_id) \
      VALUES ('#{@patron_id}', '#{@book_id}') RETURNING id;")
      @id = saved_checkout.first.fetch("id").to_i()
  end

  def delete
    DB.exec("DELETE FROM checkouts WHERE id = #{self.id};")
  end

  def self.checkedout(patron_id, book_id)
    checkouts = Checkout.all
    checkouts.each do |checkout|
      return checkout if (patron_id == checkout.patron_id && book_id == checkout.book_id)
    end
    checkout = nil
  end

  def self.retrieve_by_book(book_id)
    checkouts = Checkout.all
    checkouts.each do |checkout|
      return checkout if book_id == checkout.book_id
    end
    checkout = nil
  end

  def self.map_results_to_objects(returned_checkouts)
    checkouts = []
    returned_checkouts.each() do |checkout|
      checkouts << Checkout.new({:id => checkout.fetch('id').to_i(),
                                 :patron_id => checkout.fetch('patron_id').to_i,
                                 :book_id => checkout.fetch('book_id').to_i})
    end
    checkouts
  end

  def ==(another_checkout)
    self.id == (another_checkout.id) &&
    self.patron_id == (another_checkout.patron_id) &&
    self.book_id == (another_checkout.book_id)
  end
end
