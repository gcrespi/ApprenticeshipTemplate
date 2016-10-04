require 'rails_helper'

RSpec.describe Board, type: :model do

  context 'When having a new tic-tac-toe board' do
    let(:board) { Board.create_in_progress_board! }

    let(:upper_left_position) { BoardPosition.create!(x_coordinate: 1, y_coordinate: 1) }
    let(:middle_left_position) { BoardPosition.create!(x_coordinate: 1, y_coordinate: 2) }
    let(:lower_left_position) { BoardPosition.create!(x_coordinate: 1, y_coordinate: 3) }

    let(:upper_middle_position) { BoardPosition.create!(x_coordinate: 2, y_coordinate: 1) }
    let(:center_position) { BoardPosition.create!(x_coordinate: 2, y_coordinate: 2) }
    let(:lower_middle_position) { BoardPosition.create!(x_coordinate: 2, y_coordinate: 3) }

    let(:upper_right_position) { BoardPosition.create!(x_coordinate: 3, y_coordinate: 1) }
    let(:middle_right_position) { BoardPosition.create!(x_coordinate: 3, y_coordinate: 2) }
    let(:lower_right_position) { BoardPosition.create!(x_coordinate: 3, y_coordinate: 3) }

    let(:outside_board_position) { BoardPosition.create!(x_coordinate: 4, y_coordinate: 2) }

    it 'the game should not be finished' do
      expect(board).not_to be_finished
    end

    it 'should be player_xs turn' do
      expect(board.next_player_to_play).to be :player_x
    end

    it 'a player cannot choose a position outside the board' do
      expect{ board.apply_move_for(outside_board_position, :player_x) }.to raise_error InProgressBoard::ERROR_MESSAGE_FOR_POSITION_OUTSIDE_BOARD
    end

    context 'and player X choose the center position' do
      before do
        board.apply_move_for(center_position, :player_x)
      end

      it 'the game should not be finished' do
        expect(board).not_to be_finished
      end

      it 'the player O should be next one to play' do
        expect(board.next_player_to_play).to be :player_o
      end

      it 'the player X cannot play again because is not his turn' do
        expect{ board.apply_move_for(upper_left_position, :player_x) }.to raise_error InProgressBoard::ERROR_MESSAGE_FOR_ANOTHER_PLAYER_TURN
      end

      it 'cannot play an already taken position' do
        expect{ board.apply_move_for(center_position, :player_o) }.to raise_error InProgressBoard::ERROR_MESSAGE_POSITION_ALREADY_TAKEN
      end
    end

    context 'the upper row is filled but with moves from different players' do
      before do
        board.apply_move_for(upper_left_position, :player_x)
        board.apply_move_for(upper_middle_position, :player_o)
        board.apply_move_for(upper_right_position, :player_x)
      end

      it 'the game should not be finished' do
        expect(board).not_to be_finished
      end
    end


    context 'and the player X and O plays until X wins the principal diagonal' do
      before do
        board.apply_move_for(upper_left_position, :player_x)
        board.apply_move_for(middle_left_position, :player_o)
        board.apply_move_for(center_position, :player_x)
        board.apply_move_for(middle_right_position, :player_o)
        board.apply_move_for(lower_right_position, :player_x)
      end

      it 'the game should be finished' do
        expect(board).to be_finished
      end

      it 'the player x should be the winner' do
        expect(board.winner).to be :player_x
      end
    end

    context 'and the player X and O plays until O wins the secondary diagonal' do
      before do
        board.apply_move_for(upper_middle_position, :player_x)
        board.apply_move_for(upper_right_position, :player_o)
        board.apply_move_for(middle_left_position, :player_x)
        board.apply_move_for(center_position, :player_o)
        board.apply_move_for(middle_right_position, :player_x)
        board.apply_move_for(lower_left_position, :player_o)
      end

      it 'the game should be finished' do
        expect(board).to be_finished
      end

      it 'the player x should be the winner' do
        expect(board.winner).to be :player_o
      end
    end

    context 'and the player X and O plays until X wins the upper row' do
      before do
        board.apply_move_for(upper_left_position, :player_x)
        board.apply_move_for(middle_left_position, :player_o)
        board.apply_move_for(upper_middle_position, :player_x)
        board.apply_move_for(middle_right_position, :player_o)
        board.apply_move_for(upper_right_position, :player_x)
      end

      it 'the game should be finished' do
        expect(board).to be_finished
      end

      it 'the player x should be the winner' do
        expect(board.winner).to be :player_x
      end
    end

    context 'and the player X and O plays until X wins the left column' do
      before do
        board.apply_move_for(upper_left_position, :player_x)
        board.apply_move_for(middle_right_position, :player_o)
        board.apply_move_for(middle_left_position, :player_x)
        board.apply_move_for(center_position, :player_o)
        board.apply_move_for(lower_left_position, :player_x)
      end

      it 'the game should be finished' do
        expect(board).to be_finished
      end

      it 'the player x should be the winner' do
        expect(board.winner).to be :player_x
      end
    end
  end
end
