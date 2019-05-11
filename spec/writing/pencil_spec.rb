require 'writing/pencil'

RSpec.describe Writing::Pencil do
  describe 'attributes' do
    it { is_expected.to have_attributes(:length => 10) }
    it { is_expected.to have_attributes(:durability => 1000) }
    it { is_expected.to have_attributes(:eraser_durability => 1000) }
  end

  describe 'creation' do
    it "can be instantiated with args" do
     pencil = described_class.new eraser_durability: 696
     expect(pencil.eraser_durability).to eq(696)
     expect(pencil.length).to eq(10)
     expect(pencil.durability).to eq(1000)
    end
  end
end