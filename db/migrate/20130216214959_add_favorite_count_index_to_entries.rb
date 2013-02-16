class AddFavoriteCountIndexToEntries < ActiveRecord::Migration
  def change
    add_index :entries, :favorite_cnt
  end
end
