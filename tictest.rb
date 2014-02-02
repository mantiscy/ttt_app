require 'pry-byebug'

class Game

  def initialize
    @p1 = "nik"
    @p2 = "cris"
    @p1_sym = "x"
    @p2_sym = "o"
    @game = {a1: "", a2: "", a3: "", b1: "", b2: "", b3: "", c1: "", c2: "", c3: ""}
  end

  def winner(player, moves)

    if @game.fetch(:a1) == @game.fetch(:a2) && @game.fetch(:a1) == @game.fetch(:a3) && @game.fetch(:a1) != ""
      # binding.pry
      return player
    elsif @game.fetch(:b1) == @game.fetch(:b2) && @game.fetch(:b1) == @game.fetch(:b3) && @game.fetch(:b1) != ""
      # binding.pry
      return player
    elsif @game.fetch(:c1) == @game.fetch(:c2) && @game.fetch(:c1) == @game.fetch(:c3) && @game.fetch(:c1) != ""
      # binding.pry
      return player
    elsif @game.fetch(:a1) == @game.fetch(:b1) && @game.fetch(:a1) == @game.fetch(:c1) && @game.fetch(:a1) != ""
      # binding.pry
      return player
    elsif @game.fetch(:a2) == @game.fetch(:b2) && @game.fetch(:a2) == @game.fetch(:c2) && @game.fetch(:a2) != ""
      # binding.pry
      return player
    elsif @game.fetch(:a3) == @game.fetch(:b3) && @game.fetch(:a3) == @game.fetch(:c3) && @game.fetch(:a3) != ""
      # binding.pry
      return player
    elsif @game.fetch(:a1) == @game.fetch(:b2) && @game.fetch(:a1) == @game.fetch(:c3) && @game.fetch(:a1) != ""
      # binding.pry
      return player
    elsif @game.fetch(:a2) == @game.fetch(:b2) && @game.fetch(:a3) == @game.fetch(:c1) && @game.fetch(:a2) != ""
      # binding.pry
      return player
    elsif moves == 9
      return "Draw"
    else
      return false
    end
      
  end

  def make_move(player)
    print "Availalbe positions are: "
    @game.each {|k,v| print "#{k} " if v == "" }
    puts
    print "Select your move #{player}: "
    pos = gets.chomp
    if player == @p1
      @game[pos.to_sym] = "x"
    else
      @game[pos.to_sym] = "o"
    end
  end

  def play_game
    win = false
    p1_turn = true
    moves = 0
    puts "#{@p1} goes first!"
    while !win do 
      moves += 1

      if p1_turn && !win
        make_move(@p1)
        win = winner(@p1, moves)
        p1_turn = false
      elsif !win
        make_move(@p2)
        win = winner(@p2, moves)
        p1_turn = true
      end
    end

    if win == 'Draw'
      puts "The game is a draw..boooooring"
    else
      puts "winner is #{win}"
    end
  end

end

  game = Game.new
  game.play_game


