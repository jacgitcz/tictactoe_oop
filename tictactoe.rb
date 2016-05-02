class TicTacToe
	require_relative "board"
	require_relative "player"

	def initialize
		@game_board = Board.new
		@player1 = Player.new(1,"x")
		@player2 = Player.new(2,"o")
		@player_list = [@player1, @player2]		
	end

	def new_game
		@game_board.clear_board
		game_won = false
		winner = 0
		puts @game_board.show_board
		while @game_board.moves_left > 0 && !game_won do 			
            1.upto(2) do |player|
            	move = @player_list[player - 1].get_move
            	if move[0] < 0
            		puts "Player #{player + 1} passes"
            	else
            		@game_board.add_move(move[1],move[2],player)
            		puts @game_board.show_board
            		game_won = @game_board.win?(player)
            		if @game_board.moves_left <= 0
            			break
            		end
            	end
            	if game_won
            		winner = player
            		break
            	end
            end
            if game_won
            	break
            end
		end
		if game_won
			puts "Player #{winner} wins!"
		else
			puts "Sorry, no more moves..."
		end
	end
end