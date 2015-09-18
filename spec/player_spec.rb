require 'player'

describe Player do
  let (:board) { double :board, :collect_hits => 'A2' }
  let (:player) { described_class.new board }

  context 'player fires' do
    it 'should respond to fire and coordinates' do
      expect(player).to respond_to(:fire).with(1).argument
    end

    it 'should let the user know when losing/winning' do
      expect(board).to receive(:all_ships_sunk?)
      player.won?
    end

    it 'should let board expect check player fire hits' do
      expect(board).to receive(:checks).with('A2')
      player.fire('A2')
    end

  end
end