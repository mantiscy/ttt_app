class State < ActiveRecord::Base
  attr_accessible :player_id, :pos, :turn_for_player_id
end
