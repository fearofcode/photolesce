class AddFavoriteCountAndPublishedIndexToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :favorite_cnt, :integer

    add_index :entries, :published
  end
end
