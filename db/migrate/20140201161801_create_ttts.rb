class CreateTtts < ActiveRecord::Migration
  def change
    create_table :ttts do |t|
      t.string :name
      t.string :p1
      t.string :p2
      t.string :completed
      t.string :locked
      t.string :opponent_username
      t.string :opoonent_email

      t.timestamps
    end
  end
end
