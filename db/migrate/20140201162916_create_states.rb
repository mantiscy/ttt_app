class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :pos
      t.string :player_id
      t.string :turn_for_player_id
      t.belongs_to :ttt

      t.timestamps
    end
  end
end
