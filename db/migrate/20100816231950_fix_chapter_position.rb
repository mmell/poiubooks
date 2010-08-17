class FixChapterPosition < ActiveRecord::Migration
  def self.up
    Book.find(:all).each { |e|
      e.chapters.each_index { |ix|
        e.chapters[ix].update_attribute( :position, ix +1)
        e.chapters[ix].sub_chapters.each_index { |ixx|
          e.chapters[ix].sub_chapters[ixx].update_attribute( :position, ixx +1)
        }
        
      }
    }
  end

  def self.down
  end
end
