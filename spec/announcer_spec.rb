require File.expand_path("../../lib/announcer", __FILE__)

describe Announcer do
  context "is initialized" do
    subject(:announcer) { Announcer.new }
    let(:player_names) { ["Wesley", "Stacey"]}

    context "#ask_player_name" do
      it "saves the user-entered name to @player_names" do
        allow_any_instance_of(IO).to receive(:puts)
        allow(announcer).to receive(:gets).and_return("Jonathan")
        announcer.ask_player_name(1)
        expect(announcer.player_names[0]).to eq("Jonathan")
      end
    end

    context "#create_players" do
      it "creates a player object" do
        announcer.create_players
        expect(announcer.player1.class).to eq(Player)
      end
      it "creates a player with a name from player_names" do
        allow_any_instance_of(IO).to receive(:puts)
        allow(announcer).to receive(:gets).and_return("Wesley")
        announcer.ask_player_name(1)
        allow(announcer).to receive(:gets).and_return("Stacey")
        announcer.ask_player_name(2)
        announcer.create_players
        expect(announcer.player1.name).to eq("Wesley")
      end
    end

    context "#set_current_player" do
      it "returns one of the two players" do
        expect(announcer.set_current_player).to eq(announcer.player1 || announcer.player2)
      end
    end
  end
end
