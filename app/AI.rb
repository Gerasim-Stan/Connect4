class AI
  BIGNUM = Float::INFINITY
  LEVEL = 3

  def initialize
    @referee = Referee.new
    @win_referee = Referee.new(:winner)
  end

  def actions(board)
    actions = []
    board.width.times do |x|
      actions << x unless board.column_full?(x)
    end
    actions
  end

  def evaluate(board)
    @referee.score(board)
  end

  def evaluate_depricated(board)
    board.each_with_index.reduce(0) do |e, _, col, x|
      case e
        when @board.computer_side then x += col+1
        when @board.human_side    then x -= col+1
      end
    end
  end

  def cut_off?(board, depth)
    if depth >= LEVEL || board.full? || !@win_referee.score(board).zero?
      true
    else
      false
    end
  end

  def next_move(board)
    minimax(board)[1]
  end

  def minimax(board)
    max_value(board, nil, -BIGNUM, BIGNUM, 0)
  end

  def min_value(board, pre_action, a, b, depth)
    return [evaluate(board), pre_action] if cut_off?(board, depth)

    max_value = BIGNUM
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin(action, "X")
      min_value = max_value(new_board, action, a, b, depth+1).first
      if min_value < max_value
        max_value = min_value
        pre_action = action
      end
      b = max_value if max_value < b
    end
    [max_value, pre_action]
  end

  def max_value(board, pre_action, a, b, depth)
    return [evaluate(board), pre_action] if cut_off?(board, depth)
    max_value = -BIGNUM
    actions(board).each do |action|
      new_board = board.clone
      new_board.drop_coin(action, "O")
      min_value = min_value(new_board, action, a, b, depth + 1).first
      if min_value > max_value
        max_value = min_value
        pre_action = action
      end
      a = max_value if max_value > a
    end
    [max_value, pre_action]
  end
end
