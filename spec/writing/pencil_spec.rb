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
    let(:pencil) {described_class.new}
    subject { pencil.write(*arguments) }

    context "new sheet of paper" do
      let(:arguments) { ["", "Hello World"] }

      it "appends text to empty paper" do
        is_expected.to eq "Hello World"
      end
    end

    context "used sheet of paper" do
      let(:arguments) { ["I Am The", " Walrus"] }

      it "appends to existing text" do
        is_expected.to eq "I Am The Walrus"
      end
    end

    context "pencil just degraded" do
      let(:pencil) { described_class.new durability: 3 }
      let(:arguments) { ["", "hello"] }
      it "writes blank spaces once pencil degrades" do
        is_expected.to eq "hel  "
      end
    end

    context "pencil already fully degraded" do
      let(:pencil) { described_class.new durability: -2 }
      let(:arguments) { ["", "hello"] }
      it "writes all blank spaces" do
        is_expected.to eq "     "
      end
    end
  end

  describe "durability" do
    let(:pencil) {described_class.new}
    subject { pencil.durability }

    it "degrades after writing" do
      pencil.write("", "hello")
      is_expected.to eq 995
    end
  end
end