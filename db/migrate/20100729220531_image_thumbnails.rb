class ImageThumbnails < ActiveRecord::Migration
  def self.up
    rename_column(:users, :image, :image_src)
    add_column(:users, :image_thumb_src, :string)
  end

  def self.down
  end
end
