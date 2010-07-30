class UserName < ActiveRecord::Migration
  def self.up
    rename_column(:users, :full_name, :name)
  end

  def self.down
  end
end
