class MoveTurnToTtt < ActiveRecord::Migration
  def up
    add_column :ttts, :turn_for_player_id, :string
    remove_column :states, :turn_for_player_id
  end

  def down
    add_column :states, :turn_for_player_id, :string
    remove_column :ttts, :turn_for_player_id
  end
end
