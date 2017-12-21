require File.expand_path("../../lib/cell", __FILE__)

describe Cell do
  context "Cell is initialized with empty value" do
    subject(:cell) { Cell.new }

    it "creates a cell with value of "" " do
      expect(subject.value).to eq(' ')
    end
  end
end
