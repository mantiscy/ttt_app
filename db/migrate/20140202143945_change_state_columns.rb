class ChangeStateColumns < ActiveRecord::Migration
  def up
    remove_column :states, :player_id
    add_column :states, :p1, :boolean
  end

  def down
    add_column :states, :player_id, :string
    remove_column :states, :p1
  end
end
