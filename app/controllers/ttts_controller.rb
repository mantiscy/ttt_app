class TttsController < ApplicationController

  include TttsHelper
  
  load_and_authorize_resource
  def index
    @ttts = current_user.ttts
    @pending_ttts = current_user.ttts.where("completed = ?", 'n')
    @avail_ttts = Ttt.where("need_player = ? AND p1 != ?", 'y', current_user.id.to_s)
  end

  def all_ttts
    @ttts = Ttt.all
    @avail_ttts = Ttt.where("need_player = ?", 'y')
  end

  def new
    @ttt = Ttt.new
  end

  def create

    @ttt = Ttt.new(params[:ttt])
    if @ttt.set_initial_settings(current_user)
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
        @ttt.set_player_2(current_user)
        @ttt.save     
      end 
    end 
    @game_states = @ttt.populate_game

  end

  def play_comp
    @ttt = Ttt.find(params[:id])
    if @ttt.need_player == 'y'
      @ttt.set_comp_player
      @ttt.save
    end
    @game_states = @ttt.populate_game
    redirect_to @ttt
  end

  def update
    if @ttt.check_completed
      flash[:notice] = "Game has finished"
      redirect_to @ttt
    else
      if @ttt.need_player == 'y'
        flash[:notice] = "Need another player"
        redirect_to @ttt
      else
        state = validate_move(@ttt)
        check_game_status(@ttt, state)
      end
    end
  end

  def destroy
    @ttt = Ttt.find(params[:id])
    @ttt.destroy
    redirect_to ttts_path
  end

  #----------------------------------------------------------------#

  def check_game_status(game, state)

      if state
        if state.save
          game.states << state
          game.set_turn
          if game.save
            @game_states = game.populate_game
            if win = game.winner(@game_states)
              game.completed = 'y'
              game.save
              if win == 'Draw'
                flash[:notice] = "Game is a draw!"
                game.set_winner("Draw", current_user)
              elsif game.p2 == "-1" && !game.states.last.p1
                flash[:notice] = "PC has won the game!"
                game.set_winner("PC", current_user)
              else
                flash[:notice] = "#{current_user.email} has won the game!"  
                game.set_winner("#{current_user.email}", current_user)
              end
              redirect_to game
            else
              redirect_to game
            end
          end
        else
          flash[:notice] = "Could not make move"
          redirect_to game
        end
      else
        flash[:notice] = "You are not allowed to make that move"
        redirect_to game
      end
    
  end

  def validate_move(game)
    if game.check_completed
      flash[:notice] = "Game has ended. No more moves"
      redirect_to game
    elsif game.turn_for_player_id.to_i == current_user.id
      return game.state(params[:pc_move], params[:pos], current_user)
    elsif params[:pc_move] == 'y' && game.p2 = '-1'
      return game.state(params[:pc_move], params[:pos], current_user)
    else
      return false
    end
  end


end










