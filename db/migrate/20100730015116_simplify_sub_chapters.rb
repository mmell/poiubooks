class SimplifySubChapters < ActiveRecord::Migration
  def self.up
    add_column(:chapters, :book_id, :integer)
    Chapter.reset_column_information
    Chapter.all.each { |e| e.update_attribute(:book_id, e.parent_id) }
    remove_column(:chapters, :parent_type)
    remove_column(:chapters, :parent_id)
    
    add_column(:chapters, :is_sub_chapter, :boolean, :default => false)
  end

  def self.down
  end
end
