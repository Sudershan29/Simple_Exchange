class DropDummytables < ActiveRecord::Migration[6.1]
  def change
  	drop_table :requests
  	drop_table :transactions
  end
end
