require './lib/position'

RSpec.describe Position do
  its(:board){ is_expected.to eq %w(-)*9 }
  its(:turn){ is_expected.to eq "x" }

  context '.new(board, turn)' do
    let(:subject) do
      described_class.new(%w(x - - - - - - - -), "o")
    end

      its(:board){ is_expected.to eq %w(x - - - - - - - -) }
      its(:turn) { is_expected.to eq "o" }
  end

  context '#move' do
    let(:subject) do
      described_class.new.move(0)
    end

    its(:board){ is_expected.to eq %w(x - - - - - - - -) }
    its(:turn) { is_expected.to eq "o" }
  end

  context "#possible_moves" do
     let(:subject){ Position.new.move(0).move(1) }
     its(:possible_moves) { is_expected.to eq [2,3,4,5,6,7,8] }
  end

  context "#win?" do
    it { expect(Position.new.win?("x")).to eq false }
    it { expect(Position.new(%w(x x x
                                - - -
                                - - -)).win?("x")).to eq true }
    it { expect(Position.new(%w(- - -
                                x x x
                                - - -)).win?("x")).to eq true }
    it { expect(Position.new(%w(- - -
                                - - -
                                x x x)).win?("x")).to eq true }
    it { expect(Position.new(%w(o - -
                                o - -
                                o - -)).win?("o")).to eq true }
    it { expect(Position.new(%w(- o -
                                - o -
                                - o -)).win?("o")).to eq true }
    it { expect(Position.new(%w(- - o
                                - - o
                                - - o)).win?("o")).to eq true }
    it { expect(Position.new(%w(o - -
                                - o -
                                - - o)).win?("o")).to eq true }
    it { expect(Position.new(%w(- - o
                                - o -
                                o - -)).win?("o")).to eq true }
  end

  context '#minimax' do
    it { expect(Position.new(%w(x x x - - - - - -), "x").minimax).to eq(100) }
    it { expect(Position.new(%w(o o o - - - - - -), "o").minimax).to eq(-100) }
    it { expect(Position.new(%w(x o x x o x o x o), "x").minimax).to eq(0) }
    it { expect(Position.new(%w(x x - - - - - - -), "x").minimax).to eq(99) }
    it { expect(Position.new(%w(o o - - - - - - -), "o").minimax).to eq(-99) }
    it { expect { Timeout::timeout(5) { Position.new.minimax } }.not_to raise_error }
  end

  context "#best_move" do
  it { expect(Position.new(%w(x x - - - - - - -), "x").best_move).to eq(2) }
  it { expect(Position.new(%w(o o - - - - - - -), "o").best_move).to eq(2) }
  end
end