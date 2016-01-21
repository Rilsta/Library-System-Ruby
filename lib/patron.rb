class Patron
  attr_reader(:id, :name)
  def initialize(attribute)
    @id = attribute.fetch(:id)
    @name = attribute.fetch(:name)
  end

  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    Patron.map_results_to_objects(returned_patrons)
  end

  def self.map_results_to_objects(returned_patrons)
    patrons = []
    returned_patrons.each() do |patron|
      patrons << Patron.new({
        :id => patron.fetch('id').to_i(),
        :name => patron.fetch('name')
        })
    end
    patrons
  end

  def save
    saved_patron = DB.exec("INSERT INTO patrons (name) \
      VALUES ('#{@name}') RETURNING id;")
      @id = saved_patron.first.fetch("id").to_i()
  end

  def update(attribute)
    @name = attribute.fetch("name")
    @id = self.id
    DB.exec("UPDATE patrons SET (name) \
      = ('#{@name}') WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{self.id};")
  end

  def self.filter(filter)
    returned_patrons = DB.exec("SELECT * FROM patrons WHERE name LIKE '%#{filter}%';")
    Patron.map_results_to_objects(returned_patrons)
  end

  def self.find(id)
    patrons = Patron.all
    patrons.each do |patron|
      return patron if patron.id == id
    end
    patron = nil
  end

  def ==(another_patron)
    self.name == (another_patron.name()) &&
    self.id == (another_patron.id())
  end
end
