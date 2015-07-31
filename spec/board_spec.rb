
require 'board'

describe Board do
  let(:ship) { double :ship, :size => 2 }
  let(:unhit_ship) { double(:unhit_ship, :size => 2, :hits => 0 ) }
  let(:player) { double(:player, :fire => "") }

	describe "#place_ship" do
		it "responds to place with 3 arguments" do
			expect(subject).to respond_to(:place_ship).with(3).arguments
		end

		it "# result should be ships with coordinates" do
			coordinates = "A2"
      subject.place_ship(ship, :vertical, coordinates)
      expect(subject.ships.keys).to include(coordinates)
		end

    it "should only have vertical or horizontal direction" do
      expect(subject.place_ship(ship, :spaghetti, "A2")).to eq ["A2", "B2"]
    end

    it "can generate coordiates horizontally" do
      expect(subject.coordinates_for(ship.size, "A1", :horizontal)).to eq ["A1", "A2"]
    end

    it "can generate coordinates vertically" do
      expect(subject.coordinates_for(ship.size, "A1", :vertically)).to eq ["A1", "B1"]
    end

    it "should not let ships overlap" do
      subject.place_ship(ship, :vertical, "A2")
      expect{subject.place_ship(ship, :horizontal, "A2")}.to raise_error "Ships cannot overlap"
    end
	end

  context "constraints of the grid" do
    it "should have a default grid size" do
      expect(subject.grid_size).to eq Board::DEFAULT_GRID_SIZE
    end

    it "should not accept ships' coordinates number less than zero" do
      expect{subject.place_ship(ship, :vertical, "Z0")}.to raise_error "Invalid coordinate"
    end

    it "should not accept ships that go off the board" do
      expect{subject.place_ship(ship, :vertical, "Z50")}.to raise_error "Invalid coordinate"
    end
  end

  context "hits and misses" do
    it "hits array includes last fire position if a hit" do
      subject.place_ship(ship, :vertical, "A2")
      allow(ship).to receive(:get_hit)
      subject.checks("A2")
      expect(subject.hits).to include("A2")
    end

    it "misses array includes last fire position if a miss" do
      subject.collect_misses("A2")
      expect(subject.misses).to include("A2")
    end
  end

  describe "#all_ships_sunk?" do
    it "can tell if all ships has sunk - true" do
      subject.place_ship(ship, :vertical, "A2")
      allow(ship).to receive(:get_hit)
      subject.checks("A2")
      subject.checks("B2")
      expect(subject.all_ships_sunk?).to eq true
    end
  end

  it "should return hit if player hits a ship" do
    subject.place_ship(ship, :vertical, "A2")
    allow(ship).to receive(:get_hit)
    subject.checks("A2")
    expect(subject.collect_hits("A2")).to eq("HIT!")
  end


  # it "should return miss if player misses a ship" do
  #   ship = double :ship
  #   allow(board).to receive(:ships) { {"A2" => ship} }
  #   allow(board).to receive(:collect_misses)
  #   expect(player.fire("B2")).to eq("Miss")
  # end
end


