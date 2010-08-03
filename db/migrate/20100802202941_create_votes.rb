class CreateVotes < ActiveRecord::Migration
  def self.up
    remove_column(:comments, :vote)

    create_table :votes do |t|
      t.integer  "user_id",          :null => false
      t.integer  "comment_id",          :null => false
      t.boolean  "vote"
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
