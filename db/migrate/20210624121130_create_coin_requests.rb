class CreateCoinRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :coin_requests do |t|
      t.integer :sender
      t.integer :receiver
      t.integer :coin
      t.integer :price
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
