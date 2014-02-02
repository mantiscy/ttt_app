class TttsController < ApplicationController

  include TttsHelper
  
  load_and_authorize_resource
  def index
    @ttts = current_user.ttts
    @avail_ttts = Ttt.where("need_player = ?", 'y')
  end

  def all_ttts
    @ttts = Ttt.all
  end

  def new
    @ttt = Ttt.new
  end

  def create

    @ttt = Ttt.new(params[:ttt])
    if set_initial_settings(@ttt)
      if @ttt.save
        @ttt.users << current_user
        flash[:notice] = "Created new game"
        redirect_to ttts_path
      else
        flash[:notice] = "Error in creating game"
        redirect_to ttts_path
      end
    end
  end

  def show
    @ttt = Ttt.find(params[:id])
    if @ttt.need_player == 'y'
      if @ttt.p1.to_i != current_user.id
        @ttt = set_player_2(@ttt)
        @ttt.save     
      end 
    end 
    @game_states = populate_game(@ttt)
  end

  def update
    if @ttt.need_player == 'y'
      flash[:notice] = "Need another player"
      redirect_to @ttt
    else
      state = validate_move(@ttt)
      if state
        if state.save
          @ttt.states << state
          @ttt = set_turn(@ttt)
          if @ttt.save
            @game_states = populate_game(@ttt)
            if win = winner(@ttt, @game_states)
              @ttt.completed = 'y'
              flash[:notice] = "#{win} has won the game!"
              redirect_to @ttt
            else
              redirect_to @ttt
            end
          end
        else
          flash[:notice] = "Could not make move"
          redirect_to @ttt
        end
      else
        flash[:notice] = "You are not allowed to make that move"
        redirect_to @ttt
      end
    end
  end

  def destroy
    @ttt = Ttt.find(params[:id])
    @ttt.destroy
    redirect_to ttts_path
  end

  def set_initial_settings(game)

    # if game.need_player == 'y'
    #   game.p2 = current_user.id.to_s
    #   game.need_player = 'n'
    #   return true
    if game.need_player == nil
      game.p1 = current_user.id.to_s
      game.completed = 'n'
      game.need_player = 'y'
      game.turn_for_player_id = game.p1
      return true
    else
      return false
    end
    
  end

  def set_player_2(game)
    game.p2 = current_user.id.to_s
    game.need_player = 'n'
    game.users << current_user
    return game
  end

  def populate_game(game)

    game_states = {a1: "", a2: "", a3: "", b1: "", b2: "", b3: "", c1: "", c2: "", c3: ""}

    game.states.each do |state|
      if state.p1
        game_states[state.pos.to_sym] = 'x'
      else
        game_states[state.pos.to_sym] = 'o'
      end
    end
    return game_states
  end

  def validate_move(game)
    
    if game.turn_for_player_id.to_i == current_user.id
      state = State.new
      if current_user.id == game.p1.to_i
        state.pos = params[:pos]
        state.p1 = true
        return state
      else
        state.pos = params[:pos]
        state.p1 = false
        return state
      end
    else
      return false
    end
  end

  def set_turn(game)
    if game.states.last.p1
      game.turn_for_player_id = game.p2
    else
      game.turn_for_player_id = game.p1
    end
    return game
  end

  def winner(game, game_states)

    if game_states.fetch(:a1) == game_states.fetch(:a2) && game_states.fetch(:a1) == game_states.fetch(:a3) && game_states.fetch(:a1) != ""
      # binding.pry
      return current_user
    elsif game_states.fetch(:b1) == game_states.fetch(:b2) && game_states.fetch(:b1) == game_states.fetch(:b3) && game_states.fetch(:b1) != ""
      # binding.pry
      return current_user
    elsif game_states.fetch(:c1) == game_states.fetch(:c2) && game_states.fetch(:c1) == game_states.fetch(:c3) && game_states.fetch(:c1) != ""
      # binding.pry
      return current_user
    elsif game_states.fetch(:a1) == game_states.fetch(:b1) && game_states.fetch(:a1) == game_states.fetch(:c1) && game_states.fetch(:a1) != ""
      # binding.pry
      return current_user
    elsif game_states.fetch(:a2) == game_states.fetch(:b2) && game_states.fetch(:a2) == game_states.fetch(:c2) && game_states.fetch(:a2) != ""
      # binding.pry
      return current_user
    elsif game_states.fetch(:a3) == game_states.fetch(:b3) && game_states.fetch(:a3) == game_states.fetch(:c3) && game_states.fetch(:a3) != ""
      # binding.pry
      return current_user
    elsif game_states.fetch(:a1) == game_states.fetch(:b2) && game_states.fetch(:a1) == game_states.fetch(:c3) && game_states.fetch(:a1) != ""
      # binding.pry
      return current_user
    elsif game_states.fetch(:a2) == game_states.fetch(:b2) && game_states.fetch(:a3) == game_states.fetch(:c1) && game_states.fetch(:a2) != ""
      # binding.pry
      return current_user
    # elsif moves == 9
    #   return "Draw"
    else
      return false
    end
      
  end


end










