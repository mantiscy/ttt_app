class Ttt < ActiveRecord::Base
  attr_accessible :completed, :locked, :name, :opponent_email, :opponent_username, :p1, :p2, :user_ids, :turn_for_player_id, :need_player

  attr_accessor :last_move

  has_and_belongs_to_many :users
  has_many :states, order: :created_at


  def set_initial_settings(current_user)
    if need_player == nil
      self.p1 = current_user.id.to_s
      self.completed = 'n'
      self.need_player = 'y'
      self.turn_for_player_id = self.p1
      return true
    else
      return false
    end
  end

  def state(pc_move, pos, current_user)
    state = State.new
    if self.turn_for_player_id.to_i == current_user.id
      if current_user.id == self.p1.to_i
        state.pos = pos
        state.p1 = true
      elsif self.p2 == '-1'
        pos = self.get_pc_move
        state.pos = pos
        state.p1 = false
      else
        state.pos = pos
        state.p1 = false
      end
    elsif pc_move == 'y' && self.p2 = '-1'
      pos = self.get_pc_move
      state.pos = pos
      state.p1 = false
    end
    
    state
  end

  def set_player_2(current_user)
    self.p2 = current_user.id.to_s
    self.need_player = 'n'
    self.users << current_user
    return   
  end

  def set_comp_player
    self.p2 = "-1"
    self.need_player = 'n'
    self.users << User.create(email: 'pc')
    return
  end

  def populate_game

    game_states = {a1: "", a2: "", a3: "", b1: "", b2: "", b3: "", c1: "", c2: "", c3: ""}

    self.states.each do |state|
      if state.p1
        game_states[state.pos.to_sym] = 'x'
      else
        game_states[state.pos.to_sym] = 'o'
      end
    end
    return game_states
  end

  def get_pc_move
    game_states = self.populate_game
    game_states.each do |pos, val|
      if
        val == ""
        return pos
      end
    end
  end

  def set_turn
    if self.states.last.p1
      self.turn_for_player_id = self.p2
    else
      self.turn_for_player_id = self.p1
    end
    return 
  end

  def check_completed
    self.completed == 'y'
  end

  def winner(game_states)

    if game_states.fetch(:a1) == game_states.fetch(:a2) && game_states.fetch(:a1) == game_states.fetch(:a3) && game_states.fetch(:a1) != ""
      
      return true
    elsif game_states.fetch(:b1) == game_states.fetch(:b2) && game_states.fetch(:b1) == game_states.fetch(:b3) && game_states.fetch(:b1) != ""
      
      return true
    elsif game_states.fetch(:c1) == game_states.fetch(:c2) && game_states.fetch(:c1) == game_states.fetch(:c3) && game_states.fetch(:c1) != ""
      
      return true
    elsif game_states.fetch(:a1) == game_states.fetch(:b1) && game_states.fetch(:a1) == game_states.fetch(:c1) && game_states.fetch(:a1) != ""
      
      return true
    elsif game_states.fetch(:a2) == game_states.fetch(:b2) && game_states.fetch(:a2) == game_states.fetch(:c2) && game_states.fetch(:a2) != ""
      
      return true
    elsif game_states.fetch(:a3) == game_states.fetch(:b3) && game_states.fetch(:a3) == game_states.fetch(:c3) && game_states.fetch(:a3) != ""
      
      return true
    elsif game_states.fetch(:a1) == game_states.fetch(:b2) && game_states.fetch(:a1) == game_states.fetch(:c3) && game_states.fetch(:a1) != ""
      
      return true
    elsif game_states.fetch(:a3) == game_states.fetch(:b2) && game_states.fetch(:a3) == game_states.fetch(:c1) && game_states.fetch(:a3) != ""
      
      return true
    elsif self.states.count == 9
      return "Draw"
    else
      return false
    end
      
  end

end
