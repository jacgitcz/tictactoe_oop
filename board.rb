class Board

	LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
	MAPPING = {1 => [0,0], 2 => [0,1], 3 => [0,2],
	             4 => [1,0], 5 => [1,1], 6 => [1,2],
	             7 => [2,0], 8 => [2,1], 9 => [2,2]}


	attr_reader :moves_left

	def initialize
		clear_board
	end

	def show_board(pretty_print=true)
		if pretty_print
			outstr = "  1 2 3\n" # column headers
			@board_state.each_index do |row_index|
				outstr << "#{row_index+1}"
				row = @board_state[row_index]
				row.each do |state|
					case state
					when 0 then outstr << " -"
					when 1 then outstr << " x"
					when 2 then outstr << " o"
					end
				end
				outstr << "\n"
			end
			return outstr
		else
			outstr = ""
			@board_state.each do |row|
				row.each do |pos|
					case pos
					when 0 then outstr << "-"
					when 1 then outstr << "x"
					when 2 then outstr << "o"
					end
				end
			end
			return outstr
		end
	end

	def clear_board
		@moves_left = 9
		@board_state = [[0,0,0],[0,0,0],[0,0,0]]
	end

	def set_board(set_state)
		clear_board
		rows = [set_state[0..2], set_state[3..5],set_state[6..8]]
		@board_state.each_index do |row_index|
			row_str = rows[row_index]
			0.upto(2) do |i|
				case row_str[i]
				when "x"
					@board_state[row_index][i] = 1
					@moves_left -= 1
				when "o"
					@board_state[row_index][i] = 2
					@moves_left -= 1
				else
					next
				end
			end
		end
	end

	def add_move(col,row,player)
		if !(col.between?(1,3))
			return 5
		end
		if !(row.between?(1,3))
			return 5
		end
		if !(player.between?(1,2))
			return 4
		end
		row_index = row - 1
		col_index = col - 1
		curr_state = @board_state[row_index][col_index]
		if curr_state == 0 # empty position
			@moves_left -= 1
			@board_state[row_index][col_index] = player
			return 0
		else
			return curr_state
		end
	end

	def win?(player)
		win_found = false
		LINES.each do |line|
			line_arr = []
			line.each do |cell|
				row = MAPPING[cell][0]
				col = MAPPING[cell][1]
				line_arr << @board_state[row][col]
			end
			if line_arr.all? {|x| x == player}
				win_found = true
				break
			end
		end
	    win_found
	end
end