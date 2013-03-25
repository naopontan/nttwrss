class CreateMyRequests < ActiveRecord::Migration
  def change
    create_table :my_requests do |t|
      t.string :url

      t.timestamps
    end
  end
end
