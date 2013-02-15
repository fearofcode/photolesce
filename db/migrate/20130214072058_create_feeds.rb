class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :title
      t.string :etag
      t.time :last_modified
      t.boolean :fetched_ok

      t.timestamps
    end

    add_index :feeds, :url, unique: true
  end
end
