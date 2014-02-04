class Ttt < ActiveRecord::Base
  attr_accessible :completed, :locked, :name, :opponent_email, :opponent_username, :p1, :p2, :turn_for_player_id, :need_player, :winner, :p1_name, :p2_name, :games_list_id

  attr_accessor :last_move

  has_and_belongs_to_many :users
  has_many :states, order: :created_at


  def set_initial_settings(current_user)
    if need_player == nil
      self.p1 = current_user.id.to_s
      self.p1_name = current_user.email
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
    self.p2_name = current_user.email
    self.need_player = 'n'
    self.users << current_user
    return   
  end

  def set_comp_player
    self.p2_name = "PC"
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

  def set_winner(name, current_user)
    self.winner_name = name
    update_user_record(current_user)
    self.save
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

  private

  def update_user_record(user)
    user2 = get_other_player(user)
    if user.email == self.winner_name
      user.wins += 1
      update_other_player(user2, 'losses') unless user2 == nil
    elsif self.winner_name == 'Draw'
      user.draws += 1
      update_other_player(user2, 'draws') unless user2 == nil
    else
      user.losses += 1
      update_other_player(user2, 'wins') unless user2 == nil
    end
    user.save
  end

  def get_other_player(user)
    if self.p1.to_i == user.id && self.p2.to_i > 0
      u = User.get_user(self.p2.to_i)
      return u
    elsif self.p2.to_i > 0
      u = User.get_user(self.p1.to_i)
      return u
    else
      return nil
    end
  end

  def update_other_player(user2, key)
    user2[key.to_sym] += 1
    user2.save
  end

end



