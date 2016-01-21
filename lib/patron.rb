class Patron
  attr_reader(:id, :name, :book_history)
  def initialize(attribute)
    @id = attribute.fetch(:id)
    @name = attribute.fetch(:name)
    @book_history = attribute.fetch(:book_history)
  end
end
