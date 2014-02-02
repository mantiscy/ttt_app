class Ttt < ActiveRecord::Base
  attr_accessible :completed, :locked, :name, :opponent_email, :opponent_username, :p1, :p2, :user_ids, :turn_for_player_id, :need_player

  attr_accessor :last_move

  has_and_belongs_to_many :users
  has_many :states
end
