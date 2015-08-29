require './AI'

describe AI do

  before do
    @ai = AI.new 
  end

  it "to compute evaluate from board" do
    @board = Board[['X','O'],['X','O']]
    expect(@ai.evaluate(@board)).to eq 0
  end

  it "to tell if state is cut_off" do
    @board = Board[['.','O'],['X','O']]
    expect(@ai.cut_off?(@board,0)).to eq false
    @board = Board[['X','O'],['X','O']]
    expect(@ai.cut_off?(@board,0)).to eq true
  end

  it "to give possible actions" do
    @board = Board[['.','O','.'],
                   ['.','X','O']]
    expect(@ai.actions(@board)).to eq [0,2]
  end
end
