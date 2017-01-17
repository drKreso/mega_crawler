class CreateCrawledPages < ActiveRecord::Migration[5.0]
  def change
    create_table :crawled_pages do |t|
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
