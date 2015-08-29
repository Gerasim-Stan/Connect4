require "./app/Board.rb"
require "./app/AI.rb"
require "./app/Referee.rb"

ai = AI.new()
@referee = Referee.new(:winner)

def start_new_game
  loop do
    print "Are you with X's or with O's? "
    @human_side = gets.chomp
    break if ['O', 'X'].include? @human_side
  end
  @computer_side = @human_side == 'X' ? 'O' : 'X'
  loop do
    print "Pick board's height: "
    @board_height = gets.chomp.to_i
    break if @board_height > 0
  end
  loop do
    print "Pick board width: "
    @board_width = gets.chomp.to_i
    break if @board_width > 0
  end
  @board = Board.construct(@board_width, @board_height)
end

def start_saved_game
  file = File.open('game_save', 'r')
  saved_board = file.read.each_line.reduce([]) { |board, line| board << line.split(' ').each.to_a }
  @board_height = file.each_line.count
  @board_width = file.each_line.rewind.next.length / 3
  @board = Board.send :new, saved_board
  @computer_side = 'O'
  @human_side = 'X'
end

def pick_game
  loop do
    print "Input 'new' for new game or 'save' for your saved game: "
    game_pick = gets.chomp
    start_new_game   if game_pick == 'new'
    start_saved_game if game_pick == 'save'
    break if game_pick == 'new' or game_pick == 'save'
  end
end

File.exists?('game_save') ?  pick_game : start_new_game

(@board_height + 2).times {puts "\n"}

def input_valid?(move)
  return false unless (0..@board_width).include? move
  return false if @board.column_full? move
  true
end

def save_and_exit
  file = File.new("#{Time.now} save", 'w+')
  puts "Game is saved. Come back to continue later" if file.write(@board)
  file.close
  exit
end

[:cpu, :human].cycle do |player|
  if player == :human
    move = nil
    loop do
      print 'Next move: '
      move = gets.chomp
      save_and_exit if move == 'pause'
      break if input_valid?(move.to_i - 1)
    end
    @board.drop_coin(move.to_i-1, @human_side)
  else
    move = ai.next_move @board
    puts "ERROR" if move.nil?
    @board.drop_coin(move, @computer_side)
    puts "\e[#{@board.height+3}A"
    puts @board
  end

  winner = @referee.score(@board)

  if @board.full? || winner != 0
    puts "#{'_' * @board_width * 2}_\n#{@board}"
    case winner
      when  0 then puts "It's a \xE2\xA7\x93"
      when  1 then puts "YOU LOSE!"
      when -1 then puts "YOU WIN!"
    end
    break
  end
end
