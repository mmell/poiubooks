class Category < ActiveRecord::Base
  has_many :books

  validates_format_of( :name, :with => %r{\A[\w ,-]{2,}\z} )
  validates_uniqueness_of( :name )
end
