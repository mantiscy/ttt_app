class CreateTableTttsUsers < ActiveRecord::Migration
  def change
    create_table :ttts_users do |t|
      t.belongs_to :user
      t.belongs_to :ttt

    end
  end
end
