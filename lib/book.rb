class Book
  attr_reader(:id, :author, :genre, :title)

  def initialize(attribute)
    @id = attribute.fetch(:id)
    @genre = attribute.fetch(:genre)
    @author = attribute.fetch(:author)
    @title = attribute.fetch(:title)
  end

  
end
