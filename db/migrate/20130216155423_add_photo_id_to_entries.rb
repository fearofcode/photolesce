class AddPhotoIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :photo_id, :string
  end
end
