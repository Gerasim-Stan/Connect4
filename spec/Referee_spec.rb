require "./Referee"

describe Referee do

  before(:each) do
    @referee = Referee.new
  end

  it "to give a row score to a row of a board" do
    board = Board[['O','.','.','.','.']]
    expect(@referee.row_score(0,board)).to eq 1
    board = Board[['O','X','.','.','.']]
    expect(@referee.row_score(0,board)).to eq -1
    board = Board[['O','X','.','.','O']]
    expect(@referee.row_score(0,board)).to eq 0
    board = Board[['.','X','X','X','X']]
    expect(@referee.row_score(0,board)).to eq -1100
  end

  it "to give a score from a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    expect(@referee.score(board)).to eq -1104
  end

  it "to give a row score to a row of a board" do
    board = Board[['O'],['.'],['O'],['.'],['.']]
    expect(@referee.column_score(0,board)).to eq 11
  end

  it "to give a diagonal_down score from a position of a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    expect(@referee.diagonal_down_score(0,1,board)).to eq -1
  end

  it "to give all diagonal_up scores from a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    expect(@referee.all_diagonal_up_score(board)).to eq -1
  end

  it "to give all diagonal_down scores from a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    expect(@referee.all_diagonal_down_score(board)).to eq -1
  end

  it "to give a diagonal_up score from a position of a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    expect(@referee.diagonal_up_score(0,3,board)).to eq -1
  end

  it "to give horizontal score to a board" do
    board = Board[['O','.','.','.','.'],
                  ['O','X','.','.','.'],
                  ['O','X','.','.','O'],
                  ['.','X','X','X','X']]
    expect(@referee.horizontal_score(board)).to eq -1100
  end

  it "to give vertical score to a board" do
    board = Board[['O','O','O','.'],
                  ['.','X','X','X'],
                  ['.','.','.','X'],
                  ['.','.','.','X'],
                  ['.','.','O','X']]
    expect(@referee.vertical_score(board)).to eq -1100
  end

  it "to give a score from a collection of placements" do
    expect(@referee.heuristic('X','.','.','.')).to eq -1
    expect(@referee.heuristic('O','.','.','.')).to eq  1
    expect(@referee.heuristic('O','.','X','.')).to eq  0
    expect(@referee.heuristic('.','.','.','.')).to eq  0
    expect(@referee.heuristic('X','.','X','.')).to eq -10
  end

end
