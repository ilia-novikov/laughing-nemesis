class AddOptionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :options, :string
  end
end
