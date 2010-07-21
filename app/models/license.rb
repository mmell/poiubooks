class License < ActiveRecord::Base
  has_many :books

  validates_format_of( :url, :with => %r{\Ahttp://.{2,}\z} )
  validates_uniqueness_of( :url )
end
