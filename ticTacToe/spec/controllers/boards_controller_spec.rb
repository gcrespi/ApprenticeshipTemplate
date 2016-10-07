require 'rails_helper'

RSpec.describe BoardsController, type: :controller do

  context 'When requesting to create a new Board' do
    before do
      post :create
    end

    it 'a board should be created' do
      expect(Board.count).to eq 1
    end

    it 'the board should be not be finished' do
      expect(Board.last).not_to be_finished
    end

    context 'and requesting to play a move' do
      before do
        post :make_move, { board_id: Board.last.id, x_coordinate: 1, y_coordinate: 1, player: 'player_x'}
      end

      it 'the request should success' do
        expect(response).to have_http_status :success
      end
    end

  end
end
