class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :last_name
      t.string :role
      t.integer :wins
      t.integer :losses
      t.integer :draws
      t.string :username

      t.timestamps
    end
  end
end
