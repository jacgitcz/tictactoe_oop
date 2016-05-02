# tictactoe_oop

Odin Project: OOP with Ruby : Tic Tac Toe project

You can run this on irb using "require ./tictactoe", then <somename> = TicTacToe.new, then <somename>.new_game

The board.rb and player.rb files should be in the same directory as tictactoe.rb

The Board class has a set of rspec tests; the other two classes do not, because they use puts and gets and
writing rspec tests with io looks tricky.  Most of the work in the game is done by Board.

The Board show_board method has a flag, pretty_print, which defaults to true.  When it is false,
showboard returns the board representation as a more compact string, easier for testing.
