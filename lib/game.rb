require_relative 'board'
require_relative 'human'
require_relative 'devil'

class Game

  def initialize
    name = ask_name
    sign = ask_sign
    @human = Human.new(name, sign)
    @devil = Devil.new('Mini', alter_sign(sign))

    @color_print_available = check_for_colorize
  end

  def play
    set_first_player
    board = Board.new

    until board.game_over?
      puts ''
      color_print board
      puts ''
      @next_player.take_move(board)
      alter_player
    end

    announce_result(board, @human, @devil)
    ask_for_another_round
  end

  private
    def alter_player
      @next_player = ((@next_player == @human)? @devil : @human)
    end

    def alter_sign(sign)
      (sign == 'X')? 'O' : 'X'
    end

    def select_player_by_sign(sign)
      (@human.sign == sign)? @human : @devil
    end

    def set_first_player
      @next_player = select_player_by_sign('X')
    end

    def ask_name
      print 'Your Name Please: '
      gets.chomp.strip
    end

    def ask_sign
      puts 'Would you (1) start, should I (2)?'
      print 'If you want to start, please type 1: '

      (gets.chomp.strip.to_i <= 1)? 'X' : 'O'
    end

    def ask_for_another_round
      print 'Wanna play another round? (Y/N) '
      ans = gets.chomp.downcase
      if ans == 'y'
        play
      else
        exit
      end
    end

    def announce_result(board, player1, player2)
      if board.drawn?
        puts 'Drawn'
      elsif board.has_won?(player1.sign)
        puts "#{player1.name} Won!"
      elsif board.has_won?(player2.sign)
        puts "#{player2.name} Won!"
      else
        puts "I don't know!"
      end
    end

    def check_for_colorize
      Gem::Specification.find_by_name('colorize')
      require 'colorize'
      true
    rescue
      false
    end

    def color_print(board)
      puts board.to_s
        .gsub('X', 'X'.colorize(:blue))
        .gsub('O', 'O'.colorize(:green))
    end
end
