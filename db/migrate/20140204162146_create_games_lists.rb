class CreateGamesLists < ActiveRecord::Migration
  def change
    create_table :games_lists do |t|
      t.string :name
      t.string :path

      t.timestamps
    end
  end
end
