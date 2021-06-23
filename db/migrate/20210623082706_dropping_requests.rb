class DroppingRequests < ActiveRecord::Migration[6.1]
  def change
  	drop_table :request
  end
end
