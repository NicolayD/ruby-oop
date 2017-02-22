# General class used mainly for a game where the player guesses
# Also contains a valid_colour method used when the player creates her code
# or tries to guess the computer's,
# and a random code generator used by the computer to guess.

class Mastermind
	attr_accessor :victory
	@@colours = [ "red", "black", "white", "yellow", "blue", "green" ]
	
	def initialize
		@victory = false
	end

	# Checks if colours are valid.
	def valid_colour(colour)
		until @@colours.include?(colour)
			puts "Please choose from red, black, white, yellow, blue, and green."
			colour = gets.chomp
		end
	end

	# The computer creates a code.
	def computer_code
	 comp_colours = { 1 => @@colours[rand(6)], 2 => @@colours[rand(6)], 3 => @@colours[rand(6)], 4 => @@colours[rand(6)]}
	end

	# Takes imput from the codebreaker player.
	def new_guess
		puts "What do you think the computer's colours are?"
		puts "First:"
		first_colour = gets.chomp
		valid_colour(first_colour)
		puts "Second:"
		second_colour = gets.chomp
		valid_colour(second_colour)
		puts "Third:"
		third_colour = gets.chomp
		valid_colour(third_colour)
		puts "Fourth:"
		fourth_colour = gets.chomp
		valid_colour(fourth_colour)

		guess = { 1 => first_colour, 2 => second_colour, 3 => third_colour, 4 => fourth_colour  }
	end

	# The player tries to guess the computer's code.
	def compare(guess, code)
		black_pegs = 0						
		white_pegs = 0						

		code_copy = code.clone
		guess_copy = guess.clone

		guess_copy.each do |number, colour|			# First check for black pegs.
			if colour == code_copy[number]
				black_pegs += 1
				code_copy.delete(number)
				guess_copy.delete(number)						# Don't count the same peg as both black and white.
			end
		end
		
		guess_copy.each do |number, colour|			# Check for white pegs without considering the black and counting one white more than once.
			if code_copy.has_value?(colour)
				white_pegs += 1
				code_copy.delete(code_copy.key(colour))
			end
		end
	 
		puts "#{black_pegs} black pegs and #{white_pegs} white pegs."

		if black_pegs == 4
			puts "Right guess!"
			@victory = true
		end
	end
end

# The computer can guess the player's colour code.
# Inherits from Mastermind only for computer_code,
# a random colour code generator.
# Still needs refactoring to make it no repeat the same guess.

class CompGuesser < Mastermind
	attr_accessor :answer, :win, :white_peg_colours

	def initialize
		@answer = {}						# Contains the black pegs.
		@win = false						# Can't use the parent class @victory.
		@white_peg_colours = []	# Remember the white peg colours and reuse them.
	end

	def guess(code_hash)
		black_pegs = 0
		white_pegs = 0
		comp_guess = computer_code

		comp_guess.each do |number, colour|						
			if @answer.has_key?(number)																				# Use the black pegs.
				comp_guess[number] = @answer[number]
			elsif !@white_peg_colours.empty? && rand(2) == 1									# Change the non-black pegs with former white pegs.
				sample = @white_peg_colours.sample															# On a bit of a random basis, for fun.
				comp_guess[number] = @white_peg_colours.sample
				@white_peg_colours.delete_at(@white_peg_colours.index(sample))	# But care not to use the same white peg more than once.
			end
		end

		code_copy = code_hash.clone
		guess_copy = comp_guess.clone

		guess_copy.each do |number, colour|				# First check for black pegs.
			if colour == code_copy[number]
				black_pegs += 1
			  code_copy.delete(number)
			  guess_copy.delete(number)							# Don't the same peg as both black and white. If it's black,
			  @answer[number] = colour      				# it shouldn't be regarded in the following check for white pegs.
			end
		end
			
		guess_copy.each do |number, colour|				# Check for white pegs without considering the black and counting one more than once.
			if code_copy.has_value?(colour)
				white_pegs += 1
				code_copy.delete(code_copy.key(colour))
				@white_peg_colours.push(colour)
			end
		end

		puts "#{black_pegs} black pegs and #{white_pegs} white pegs."
		if black_pegs == 4
			puts "Right guess!"
			@win = true
		end
		puts comp_guess
	end
end

# The player creates a code.
class HumanCoder < Mastermind
	attr_accessor :player_colours

	def valid_colour(colour)
		super
	end

	def initialize
		puts "Choose four colours from red, black, white, yellow, blue, and green."
		puts "They don't have to be different."
		puts "First:"
		first_colour = gets.chomp
		valid_colour(first_colour)
		puts "Second:"
		second_colour = gets.chomp
		valid_colour(second_colour)
		puts "Third:"
		third_colour = gets.chomp
		valid_colour(third_colour)
		puts "Fourth:"
		fourth_colour = gets.chomp
		valid_colour(fourth_colour)

		@player_colours = { 1 => first_colour, 2 => second_colour, 3 => third_colour, 4 => fourth_colour  }
	end
end

# Start the game.
turns = 12
i = 0

puts "Welcome to Mastermind!"
game = Mastermind.new
puts "Do you want to make the code or break the code?"
puts "Answer with 'break' or 'make'."
answer = gets.chomp

if answer == "break"
	puts "You have 12 turns to guess the computer's colour code."

	new_code = game.computer_code
	puts new_code

	while i < turns
		guess = game.new_guess
		puts
		game.compare(guess,new_code)
		if game.victory
			puts "You won!"
			break
		end
		i += 1
		if i == 12
			puts "Sorry, you couldn't guess."
			puts "The answer is: "
			new_code.each { |num, col| print col + " " }
			puts
		end
	end
elsif answer == "make"
	new_player = HumanCoder.new
	computer = CompGuesser.new
	puts
	puts "Thank you."
	puts "Now the computer will try to guess your code."

	while i < turns
	 computer.guess(new_player.player_colours)
	 puts
	 if computer.win
	 	break
	 end
	 i += 1
	end
else 
	puts "You must answer with 'break' or 'make'."
end