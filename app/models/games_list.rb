class GamesList < ActiveRecord::Base
  attr_accessible :name, :path

  has_one :ttt
end
