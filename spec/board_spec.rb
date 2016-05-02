require_relative "../board"

describe Board do

	before(:all) do
		@b = Board.new
	end

	it "is empty when created" do
		expect(@b.moves_left).to eq 9
		expect(@b.show_board(false)).to eq "---------"
	end

	it "can be set to a known state" do
		@b.set_board("x---x---x")
		expect(@b.moves_left).to eq 6
		expect(@b.show_board(false)).to eq "x---x---x"
	end

	it "can clear the board" do
		@b.set_board("xoooxoxx-")
		expect(@b.moves_left).to eq 1
		expect(@b.show_board(false)).to eq "xoooxoxx-"
		@b.clear_board
		expect(@b.moves_left).to eq 9
		expect(@b.show_board(false)).to eq "---------"
	end

	it "can pretty-print the board" do
		@b.set_board("xo--oxo-x")
		expect(@b.show_board(false)).to eq "xo--oxo-x"
		expect(@b.show_board).to eq " 1 2 3\n1 x o -\n2 - o x\n3 o - x\n"		
	end

	it "can add moves" do
		@b.clear_board
		expect(@b.moves_left).to eq 9
		@b.add_move(2,2,1)
		expect(@b.moves_left).to eq 8
		expect(@b.show_board(false)).to eq "----x----"
		@b.add_move(1,1,2)
		expect(@b.moves_left).to eq 7
		expect(@b.show_board(false)).to eq "o---x----"
	end

	it "detects illegal moves and does not change board state on illegal move" do
		@b.set_board("--xxoo-ox")
		expect(@b.moves_left).to eq 3
		expect(@b.add_move(3,1,1)).to eq 1 # position already occupied by player 1
		expect(@b.moves_left).to eq 3
		expect(@b.add_move(2,2,1)).to eq 2 # pos occupied by player 2
		expect(@b.add_move(1,1,3)).to eq 4 # illegal player
		expect(@b.add_move(4,3,2)).to eq 5 # illegal position
		expect(@b.moves_left).to eq 3
		expect(@b.show_board(false)).to eq "--xxoo-ox"
	end

	it "detects win states" do
		@b.set_board("xx-o-oxox")
		expect(@b.win?(1)).to eq false
		expect(@b.win?(2)).to eq false
		@b.add_move(3,1,1)
		expect(@b.win?(1)).to eq true
		expect(@b.win?(2)).to eq false
		expect(@b.show_board(false)).to eq "xxxo-oxox"
		@b.set_board("oxx-o-x-o")
		expect(@b.win?(2)).to eq true
		@b.set_board("x--x--x--")
		expect(@b.win?(1)).to eq true
		@b.set_board("------ooo")
		expect(@b.win?(2)).to eq true
		expect(@b.win?(1)).to eq false
	end
end