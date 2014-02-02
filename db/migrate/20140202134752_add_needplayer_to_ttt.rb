class AddNeedplayerToTtt < ActiveRecord::Migration
  def change
    add_column :ttts, :need_player, :string
  end
end
