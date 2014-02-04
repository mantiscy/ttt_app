class AddWinnerToTtt < ActiveRecord::Migration
  def change
    add_column :ttts, :winner_name, :string
  end
end
