class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :ph_number
      t.integer :currency
      t.integer :coin

      t.timestamps
    end
  end
end
