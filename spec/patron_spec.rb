require ('spec_helper')

describe(Patron) do
  describe('#id, #name') do
    it('will return information when inputted') do
      patrons = Patron.new({id: nil,
                            name: 'Mark'
                            })
      expect(patrons.id()).to(eq(nil))
      expect(patrons.name()).to(eq('Mark'))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves input from database and stores to an array') do
      test_patron = create_test_patron
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe('#update') do
    it('updates input from database and stores to an array') do
      test_patron = create_test_patron
      test_patron.save()
      test_patron.update({"name" => 'Mark'})
      expect(test_patron.name).to eq('Mark')
    end
  end

  describe('#delete') do
    it('deletes information from database') do
      test_patron = create_test_patron
      test_patron.save
      test_patron2 = create_test_patron_2
      test_patron2.save
      test_patron.delete
      expect(Patron.all()).to(eq([test_patron2]))
    end
  end

  describe('.filter') do
    it('filters based on user preference') do
      patron1 = create_test_patron
      patron1.save
      patron2 = create_test_patron_2
      patron2.save
      expect(Patron.filter('Jeff')).to(eq([patron2]))
    end
  end

  describe("#==") do
    it("is the same patron if it has the same information") do
      patron1 = create_test_patron
      patron2 = create_test_patron
      expect(patron1).to(eq(patron2))
    end
  end
end
