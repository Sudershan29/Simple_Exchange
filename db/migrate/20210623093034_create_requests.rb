class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.integer :amount
      t.integer :value
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
