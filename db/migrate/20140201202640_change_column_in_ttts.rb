class ChangeColumnInTtts < ActiveRecord::Migration
  def up
    remove_column :ttts, :opoonent_email
    add_column :ttts, :opponent_email, :string
  end

  def down
    add_column :ttts, :opoonent_email, :string
    remove_column :ttts, :opponent_email
  end
end
