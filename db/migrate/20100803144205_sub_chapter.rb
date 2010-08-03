class SubChapter < ActiveRecord::Migration
  def self.up
    add_column(:chapters, :parent_id, :integer)
    add_column(:chapters, :parent_type, :string)
    execute("update chapters set parent_id = book_id, parent_type = 'Book'" )
    remove_column(:chapters, :book_id)
    remove_column(:chapters, :is_sub_chapter)
  end

  def self.down
  end
  
end
