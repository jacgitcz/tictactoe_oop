class Board

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
		# row checks
		win_found = false
		@board_state.each do |row|
			if row.all? {|x| x == player}
				win_found = true
				break
			end
		end
		if !win_found  # col checks
			0.upto(2) do |col|
				col_arr = []
				@board_state.each do |row|
					col_arr << row[col]
				end
				if col_arr.all? {|x| x == player}
					win_found = true
					break
				end
			end
		end
		if !win_found # diagonal checks
			# diagonal must pass through central position
			if @board_state[1][1] != player
				win_found = false
			else
				diag1 = [@board_state[0][0],@board_state[1][1],@board_state[2][2]]
				diag2 = [@board_state[0][2],@board_state[1][1],@board_state[2][0]]
				if diag1.all? {|x| x == player}
					win_found = true
				elsif diag2.all? {|x| x == player}
					win_found = true
				else
				    win_found = false
				end				
			end				
		end
	    win_found
	end
end