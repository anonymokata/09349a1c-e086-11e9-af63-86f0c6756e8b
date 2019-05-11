require 'writing/pencil'

RSpec.describe Writing::Pencil do
  describe '#new' do
    it { is_expected.to have_attributes(:length => 10) }
    it { is_expected.to have_attributes(:durability => 1000) }
    it { is_expected.to have_attributes(:eraser_durability => 1000) }

    it "can be instantiated with args" do
     pencil = described_class.new eraser_durability: 696
     expect(pencil.eraser_durability).to eq(696)
     expect(pencil.length).to eq(10)
     expect(pencil.durability).to eq(1000)
    end
  end

  describe "#write" do
    context "new sheet of paper" do
      it "appends text to empty paper" do
        paper = ""
        paper = subject.write(paper, "Hello World")
        expect(paper).to eq "Hello World"
      end
    end

    context "used sheet of paper" do
      it "appends text to existing text" do
        paper = "I Am the "
        paper = subject.write(paper, "Walrus")
        expect(paper).to eq "I Am the Walrus"
      end
    end
  end
end