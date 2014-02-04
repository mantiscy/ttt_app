class AddNamesToPlayersInTttGame < ActiveRecord::Migration
  def change
    add_column :ttts, :p1_name, :string
    add_column :ttts, :p2_name, :string
  end
end
