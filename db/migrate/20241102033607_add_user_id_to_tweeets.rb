class AddUserIdToTweeets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweeets, :user_id, :integer
  end
end
