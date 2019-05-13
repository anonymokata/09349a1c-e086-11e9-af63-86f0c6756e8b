require 'writing/pencil'

RSpec.describe Writing::Pencil do
  let(:pencil) { described_class.new }

  describe '#new' do
    context 'no args' do
      it { is_expected.to have_attributes(:length => 10) }
      it { is_expected.to have_attributes(:point_durability => 1000) }
      it { is_expected.to have_attributes(:eraser_durability => 1000) }
    end

    context 'with args' do
      subject { described_class.new eraser_durability: 696, length: 5, point_durability: 22 }
      it { is_expected.to have_attributes(:eraser_durability => 696) }
      it { is_expected.to have_attributes(:length => 5) }
      it { is_expected.to have_attributes(:point_durability => 22) }
    end
  end

  describe "#write" do
    subject { pencil.write(*arguments) }

    context "new sheet of paper" do
      let(:arguments) { ["", "Hello World"] }

      it "appends text to empty paper" do
        is_expected.to eq "Hello World"
      end
    end

    context "used sheet of paper" do
      let(:arguments) { ["She sells sea shells", " down by the sea shore"] }

      it "appends to existing text" do
        is_expected.to eq "She sells sea shells down by the sea shore"
      end
    end

    context "pencil just degraded" do
      let(:pencil) { described_class.new point_durability: 4 }
      let(:arguments) { ["", "Text"] }
      it "begins writing blank spaces once pencil degrades" do
        is_expected.to eq "Tex "
      end
    end

    context "pencil already fully degraded" do
      let(:pencil) { described_class.new point_durability: -100 }
      let(:arguments) { ["", "hello"] }
      it "writes only blank spaces" do
        is_expected.to eq "     "
      end
    end

    describe "@point_durability" do
      subject { pencil.point_durability }
  
      context "lowercase letters" do
        it "degrades by point value of one for each char" do
          pencil.write("", "hello")
          is_expected.to eq 995
        end
      end
  
      context "UPPERCASE letters" do
        it "degrades by point value of two for each char" do
          pencil.write("", "HELLO")
          is_expected.to eq 990
        end
      end
  
      context "lowercase & UPPERCASE letters" do
        it "degrades by 0 for whitespace, 1 for lower case/special, 2 for UPPER case" do
          pencil.write("", "I AM YELLING and now i'm not.")
          is_expected.to eq 967
        end
      end
    end
  end

  describe "#sharpen" do
    before(:example) do
      subject.write("", "hello")
      subject.sharpen
    end

    context "pencil is not used up" do
      it "resets @point_durability back to original value" do
        expect(subject.point_durability).to eq 1000
      end

      it "reduces @length of pencil by 1" do
        expect(subject.length).to eq 9
      end
    end

    context "pencil is used up" do
      subject { described_class.new length: 0 }

      it "does not reset @point_durability" do
        expect(subject.point_durability).to eq 995
      end

      it "does not reduce @length of pencil" do
        expect(subject.length).to eq 0
      end
    end
  end

  describe "#erase" do
    let(:paper) { "lorem ipsum dolor lorem ipsum dolor sit amet" }

    context "searched text is found" do
      context "a full word" do
        it "erases the last occurence of text" do
          subject.erase(paper, "lorem")
          expect(paper).to eq "lorem ipsum dolor       ipsum dolor sit amet"
        end
      end

      context "partial word" do
        it "erases the last occurence of text" do
          subject.erase(paper, "um")
          expect(paper).to eq "lorem ipsum dolor lorem ips   dolor sit amet"
        end
      end

      context "contains whitespace" do
        it "erases the last occurence of text" do
          subject.erase(paper, "dolor sit")
          expect(paper).to eq "lorem ipsum dolor lorem ipsum           amet"
        end
      end       
    end

    context "searched text isn't found" do
      it "erases nothing" do
        subject.erase(paper, "chuck")
        expect(paper).to eq "lorem ipsum dolor lorem ipsum dolor sit amet"
      end
    end

    context "dull eraser" do
      context "eraser becomes dull while erasing" do
        let(:pencil) { described_class.new eraser_durability: 3 }
        it "erases text, in reverse order, until eraser becomes dull" do
          pencil.erase(paper, "dolor")
          expect(paper).to eq "lorem ipsum dolor lorem ipsum do    sit amet"
        end
      end

      context "eraser already dull when erasing starts" do
        let(:pencil) { described_class.new eraser_durability: 0 }
        it "does not erase any text" do
          pencil.erase(paper, "dolor")
          expect(paper).to eq "lorem ipsum dolor lorem ipsum dolor sit amet"
        end
      end
    end

    describe "@eraser_durability" do
      it "degrades eraser by 1 for each char erased" do
        subject.erase(paper, "dolo")
        expect(subject.eraser_durability).to eq(996)
      end

      it "degrades eraser by 0 when erasing whitespace" do
        subject.erase(paper, "ipsum dolor")
        expect(subject.eraser_durability).to eq(990)
      end
    end
  end
end