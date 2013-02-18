class AddAssocationIndexesToEntries < ActiveRecord::Migration
  def change
    add_index :entries, :feed_id
    add_index :entries, :tumblr_tag_id
  end
end
