require 'writing/pencil'

RSpec.describe "Pencil" do
  describe 'creation' do
    it "can be instantiated" do
      expect(Writing::Pencil).to receive(:new)
      Writing::Pencil.new()
    end
  end
end