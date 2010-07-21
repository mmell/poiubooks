module ExampleSetupHelper
  def create_book
    Factory.create(:book)
  end
  
  def create_chapter
    Factory.create(:chapter)
  end

  def create_sub_chapter
    Factory.create(:sub_chapter)
  end
  
  
end
