class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :last_name
      t.string :role
      t.string :wins
      t.string :losses
      t.string :draws
      t.string :username

      t.timestamps
    end
  end
end
