class AddUserIdToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :user_id, :integer
    add_index :accounts, :user_id
  end
end