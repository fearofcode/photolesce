class AddTumblrTagIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :tumblr_tag_id, :integer
  end
end
