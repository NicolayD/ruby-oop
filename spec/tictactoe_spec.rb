require 'spec_helper'
require 'tictactoe.rb'

describe TicTacBoard do

	before(:each) do
    @game = TicTacBoard.new
  end

	it 'creates a 3x3 board with indices' do
		expect(@game.board[0]).to eq(["<", 1,   2,   3 ])
		expect(@game.board[1]).to eq([1, " ", " ", " "])
		expect(@game.board[2]).to eq([2, " ", " ", " "])
		expect(@game.board[3]).to eq([3, " ", " ", " "])
	end

	# Deliberate failure
	it 'creates a bord with a wrong index' do
		expect(@game.board[3]).to eq([5, " ", " ", " "])
	end

	context '#victory' do
		it 'is a win for X if there are three X in a row' do
			@game.board[1] = [1, "X", "X", "X"]
			expect(@game.victory).to be_true
		end

		it 'is a win for O if there are three diagonal Os' do
			@game.board[1][1] = "O"
			@game.board[2][2] = "O"
			@game.board[3][3] = "O"
			expect(@game.victory).to be_true
		end

		it 'is a win for X if there are three vertical Xs' do
			@game.board[1][1] = "X"
			@game.board[2][1] = "X"
			@game.board[3][1] = "X"
			expect(@game.victory).to be_true
		end

		it 'does not stop the game if there are only two in a row' do
			@game.board[1][1] = "O"
			@game.board[2][2] = "O"
			expect(@game.victory).to be_false
		end

		it 'does not stop the game if there are two in a row' do
			@game.board[1][1] = "X"
			@game.board[1][2] = "X"
			expect(@game.victory).to be_false
		end

		it 'does not stop if there are two in a diagonal' do
			@game.board[3][1] = "O"
			@game.board[2][2] = "O"
			expect(@game.victory).to be_false
		end

		it 'stops only if three of the same are next to each other' do
			@game.board[2] = [2, "X", "O", "X"]
			expect(@game.victory).to be_false
		end
	end
end