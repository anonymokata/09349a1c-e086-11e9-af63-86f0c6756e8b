require 'writing/pencil'

RSpec.describe Writing::Pencil do
  describe '#new' do
    context 'no args' do
      it { is_expected.to have_attributes(:length => 10) }
      it { is_expected.to have_attributes(:durability => 1000) }
      it { is_expected.to have_attributes(:eraser_durability => 1000) }
    end

    context 'with args' do
      subject { described_class.new eraser_durability: 696, length: 5, durability: 22 }
      it { is_expected.to have_attributes(:eraser_durability => 696) }
      it { is_expected.to have_attributes(:length => 5) }
      it { is_expected.to have_attributes(:durability => 22) }
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

    it "degrades after writing" do
      paper = ""
      paper = subject.write(paper, "hello")
      expect(subject.durability).to be(995)
    end
  end
end