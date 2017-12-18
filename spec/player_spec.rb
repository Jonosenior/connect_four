require File.expand_path("../../lib/player", __FILE__)

describe Player do
  context "initialized with name and marker" do
    let(:player) { Player.new("Jonathan", "X") }

    it "returns player name" do
      expect(player.name).to eq("Jonathan")
    end

    it "returns the player marker" do
      expect(player.marker).to eq("X")
    end
  end
  # context "passed a name of nil" do
  #   let(:player) { Player.new("", "X") }
  #
  #   it "puts the full player name instead" do
  #     expect(player.name).to eq("Player 1")
  #   end
  # end
end
