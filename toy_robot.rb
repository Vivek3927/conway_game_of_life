require 'byebug'
class Robot
  attr_accessor :x, :y, :facing

  def initialize
    @x = nil
    @y = nil
    @facing = nil
  end

  def place(x, y, facing)
    @x = x
    @y = y
    @facing = facing
  end

  def move
    return unless placed?

    case @facing
    when 'NORTH'
      @y += 1 if @y < 4
    when 'EAST'
      @x += 1 if @x < 4
    when 'SOUTH'
      @y -= 1 if @y > 0
    when 'WEST'
      @x -= 1 if @x > 0
    end
  end

  def left
    rotate(-1)
  end

  def right
    rotate(1)
  end

  def report
    puts "Output: #{@x},#{@y},#{@facing}" if placed?
  end

  private

  def rotate(direction)
    directions = ['NORTH', 'EAST', 'SOUTH', 'WEST']
    current_index = directions.index(@facing)
    new_index = (current_index + direction) % 4
    @facing = directions[new_index]
  end

  def placed?
    !@x.nil? && !@y.nil? && !@facing.nil?
  end
end

class ToyRobotSimulator
  def initialize
    @robot = Robot.new
  end

  def execute(command)
    case command
    when /^PLACE (\d+),(\d+),(NORTH|EAST|SOUTH|WEST)$/
      @robot.place($1.to_i, $2.to_i, $3)
    when 'MOVE'
      @robot.move
    when 'LEFT'
      @robot.left
    when 'RIGHT'
      @robot.right
    when 'REPORT'
      @robot.report
    end
  end
end

# Example usage:
simulator = ToyRobotSimulator.new

# Test data
commands = [
  'MOVE',         # Ignored, no valid PLACE command executed yet
  'PLACE 0,0,NORTH',
  'MOVE',
  'REPORT',       # Output: 0,1,NORTH
  'LEFT',
  'MOVE',
  'REPORT',       # Output: 0,1,WEST
  'PLACE 1,2,EAST',
  'MOVE',
  'MOVE',
  'RIGHT',
  'MOVE',
  'REPORT'        # Output: 4,2,SOUTH
]

commands.each do |command|
  simulator.execute(command)
end
