module ExampleSetupHelper
  def create_book
    Factory.create(:book)
  end
  
  def create_chapter
    Factory.create(:chapter)
  end
  
end
