class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :content
      t.string :link
      t.string :title
      t.datetime :published

      t.timestamps

      t.belongs_to :feed
    end

    add_index :entries, :content, unique: true
  end
end
