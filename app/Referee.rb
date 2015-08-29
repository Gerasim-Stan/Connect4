class Referee
  def initialize(func=:heuristic)
    @func = func
  end

  def score(board)
    score = 0
    score += horizontal_score board
    score += vertical_score board
    score += all_diagonal_up_score board
    score += all_diagonal_down_score board
  end

  def horizontal_score(board)
    board.height.times.reduce(0) { |score, y| score += row_score(y,board) }
  end

  def vertical_score(board)
    board.width.times.reduce(0) { |score, x| score += column_score(x,board) }
  end

  def row_score(y, board)
    (board.width-3).times.reduce(0) do |score, x|
      score += val(board[x,y],board[x+1,y],board[x+2,y],board[x+3,y])
    end
  end

  def column_score(x, board)
    (board.height-3).times.reduce(0) do |score, y|
      score += val(board[x,y],board[x,y+1],board[x,y+2],board[x,y+3])
    end
  end

  def all_diagonal_down_score(board)
    (board.width-3).times.reduce(0) do |_, x|
      (board.height-3).times.reduce(0) do |_, y|
        diagonal_down_score(x, y, board)
      end
    end
  end

  def all_diagonal_up_score(board)
    (board.width-3).times.reduce(0) do |_, x|
      (board.height-3).times.reduce(0) do |_, y|
        diagonal_up_score(x, y+3, board)
      end
    end
  end

  def diagonal_down_score(x,y,board)
    val(board[x,y],board[x+1,y+1],board[x+2,y+2],board[x+3,y+3])
  end

  def diagonal_up_score(x,y,board)
    val(board[x,y],board[x+1,y-1],board[x+2,y-2],board[x+3,y-3])
  end

  # Pick function between #heuristic and #winner
  def val(a, b, c, d)
    self.send(@func,a,b,c,d)
  end

  # The heuristic gives points to a four cells' space in which it might be
  # possible to get a 4x4. if both X's and O's are present, it is not possible
  # to get a 4x4, and the function yields 0. Otherwise, the function returns: 
  #
  # For 1 O:   1
  # For 2 O's: 10
  # For 3 O's: 100
  # For 4 O's: 1000
  # For 1 X:   -1
  # For 2 X's: -10
  # For 3 X's: -100
  # For 4 X's: -1000

  def heuristic(a, b, c, d)
    x = 0
    o = 0
    [a,b,c,d].each do |e|
      x += 1 if e == 'X'
      o += 1 if e == 'O'
    end
    return 0 if x > 0 && o > 0
    return -(10**(x-1)) if x > 0
    return 10**(o-1) if o > 0
    return 0
  end

  def winner(a, b, c, d)
    x = 0
    o = 0
    [a, b, c, d].each do |e|
      x += 1 if e == 'X'
      o += 1 if e == 'O' 
    end
    return  0 if x > 0 && o > 0
    return -1 if x == 4
    return  1 if o == 4
    return  0
  end
end
