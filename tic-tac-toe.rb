class TicTacBoard
	attr_accessor :board

	def initialize
		@board = [["<", 1,   2,   3 ],

				    [1, " ", " ", " "],

				    [2, " ", " ", " "],

				    [3, " ", " ", " "]]
	end

	def put_o(answer)
		until answer[0] =~ /1|2|3/ && answer[1] =~ /1|2|3/
			puts "Please enter two numbers from 1 to 3."
			answer = gets.chomp
		end

		while true
			if  !(@board[answer[0].to_i][answer[1].to_i] == " ")
				puts "Please choose an empty tile."
				answer = gets.chomp
			else
				x,y = answer[0].to_i, answer[1].to_i
				@board[x][y] = "O"
				break
			end
		end
	end

	def put_x(answer)
		until answer[0] =~ /1|2|3/ && answer[1] =~ /1|2|3/
			puts "Please enter two numbers from 1 to 3."
			answer = gets.chomp
		end

		while true
			if !(@board[answer[0].to_i][answer[1].to_i] == " ")
				puts "Please choose an empty tile."
				answer = gets.chomp
			else
				x,y = answer[0].to_i, answer[1].to_i
				@board[x][y] = "X"
				break
			end
		end
	end

	def victory
		if !board.join.include?(" ")
			"Draw."
		elsif @board[1][1] == @board [2][2] && @board[2][2] == @board[3][3] && @board[3][3] != " "
			"#{@board[1][1]} wins!"
		elsif @board[1][1] == @board [2][1] && @board[2][1] == @board[3][1] && @board[3][1] != " "
			"#{@board[1][1]} wins!"
		elsif @board[1][2] == @board [2][2] && @board[2][2] == @board[3][2] && @board[3][2] != " "
			"#{@board[1][2]} wins!"
		elsif @board[1][3] == @board [2][3] && @board[2][3] == @board[3][3] && @board[3][3] != " "
			"#{@board[1][3]} wins!"
		elsif @board[1][1] == @board [1][2] && @board[1][2] == @board[1][3] && @board[1][3] != " "
			"#{@board[1][1]} wins!"
		elsif @board[2][1] == @board [2][2] && @board[2][2] == @board[2][3] && @board[2][3] != " "
			"#{@board[2][1]} wins!"
		elsif @board[3][1] == @board [3][2] && @board[3][2] == @board[3][3] && @board[3][3] != " "
			"#{@board[3][1]} wins!"
		elsif @board[1][3] == @board [2][2] && @board[2][2] == @board[3][1] && @board[3][1] != " "
			"#{@board[1][3]} wins!"
		end
	end

	def show_board
		@board.each do |line|
			puts line.each { |el| el }.join " "
		end
	end
end

another_game = "yes"

while another_game != "no"

	puts "Welcome! You're about to play a game of Tic Tac Toe."

	new_game = TicTacBoard.new

	answer = ''
	until answer.upcase == "O" || answer.upcase == "X"
		puts "Please choose O or X."
		answer = gets.chomp

		if answer.upcase == "O"
			player1 = "O"
			player2 = "X"
		else
			player1 = "X"
			player2 = "O"
		end
	end

	until new_game.victory
		puts
		new_game.show_board
		puts
		puts "First player. Choose the coordinates for your move."
		answer = gets.chomp

		if player1 == "O"
			new_game.put_o(answer)
		else
			new_game.put_x(answer)
		end

		if new_game.victory
			puts
			new_game.show_board
			puts
			puts new_game.victory
			break
		end

		new_game.show_board
		puts
		puts "Second player. Choose the coordinates of an empty tile."
		answer = gets.chomp

		if player2 == "O"
			new_game.put_o(answer)
		else 
			new_game.put_x(answer)
		end

		if new_game.victory
			puts
			new_game.show_board
			puts
			puts new_game.victory
			break
		end
	end
 
	puts "Would you like to play another game?"
	another_game = gets.chomp

	if another_game.downcase == "no"
		puts "Thank you for playing!"
		break
	else
		puts
		puts "Well, you didn't say 'no', so there you go!"
		puts
	end
end