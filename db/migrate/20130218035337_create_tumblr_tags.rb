class CreateTumblrTags < ActiveRecord::Migration
  def change
    create_table :tumblr_tags do |t|
      t.string :tag

      t.timestamps
    end
  end
end
