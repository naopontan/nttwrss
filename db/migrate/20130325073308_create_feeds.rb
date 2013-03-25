class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.references :my_request
      t.string :title
      t.string :link
      t.string :description
      t.datetime :pub_date
      t.text :content

      t.timestamps
    end
    add_index :feeds, :my_request_id
  end
end
