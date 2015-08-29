require "./Board"

describe Board do

  it "to be able drop a coin" do
    @board = Board.construct(3, 3)
    expect(@board[0, 2]).to eq '.'
    @board.drop_coin 0, 'X'
    @board.drop_coin 1, 'O'
    expect(@board[0, 2]).to eq 'X'
    expect(@board[1, 2]).to eq 'O'
  end

  it "to tell coin at position" do
    @board = Board[['_', '_'], ['O', '_']]
    @board[1, 0] = 'X'
    expect(@board[1, 0]).to eq 'X'
    expect(@board[0, 1]).to eq 'O'
  end

  it "to tell if column is full" do
    @board = Board[['X', '.'],['X', '.']]
    expect(@board.column_full?(1)).to be_falsey
    expect(@board.column_full?(0)).to be_truthy
  end

  it "to tell dimentions" do
    board = Board.construct(4, 5)
    expect(board.width).to eq 4
    expect(board.height).to eq 5
  end

  it "to tell if board is full" do
    @board = Board[['X', '.'], ['X', 'O']]
    expect(@board.full?).to be_falsey
    @board[1, 0] = 'X'
    expect(@board.full?).to be_truthy
  end

  it "to clone" do
    @board1 = Board[['1', '1'], ['1', '1']]
    @board2 = @board1.clone
    @board2[0, 0] = '2'
    expect(@board1[0, 0]).to eq '1'
    expect(@board2[0, 0]).to eq '2'
  end

  it "to render" do
    @board = Board[['X', '.', '.'],
                   ['X', 'O', 'O'],
                   ['O', 'X', 'X']]
    expect(@board.simple_render).to eq "X..\nXOO\nOXX\n"
  end
end
