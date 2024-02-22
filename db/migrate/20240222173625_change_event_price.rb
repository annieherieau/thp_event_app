class ChangeEventPrice < ActiveRecord::Migration[7.1]
  def change
    change_column :events, :price, :integer, :default => 0, :null => false
  end
end
