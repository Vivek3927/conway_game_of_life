require_relative 'toy_robot'

describe Robot do
  describe '#place' do
    let(:toy) { ToyRobotSimulator.new}
    it 'return value' do
      expect(toy.execute('REPORT')).to be nil
    end
  end
end