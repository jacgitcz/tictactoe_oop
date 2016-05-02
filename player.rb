class Player

	attr_reader :player_num, :player_mark

	def initialize(player_num,player_mark)
		@player_num = player_num
		@player_mark = player_mark
	end

	def get_move
		valid = false
		while ! valid do
			print "Player #{@player_num}: please enter your move (col, row) or 9 to pass:  "
			movestr = gets.chomp
			move = movestr.split(",").map {|x| x.strip.to_i}
			if move[0] == 9 # player wants to pass
				result = [-@player_num, -1, -1]
				valid = true
			elsif move.length == 2 &&
			      move[0].between?(1,3) && 
			      move[1].between?(1,3)
				  
				  result = [@player_num, move[0],move[1]]
				  valid = true
			else
				puts "Column and row numbers should be in the range 1 to 3"
				puts "Or you can enter a 9 to pass.  Please try again."
			end 
		end
		result
	end
end