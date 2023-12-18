class GameOfLife
  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @board = generate_random_board
  end

  def generate_random_board
    Array.new(@rows) { Array.new(@cols) { rand(2) == 0 ? :dead : :alive } }
  end

  def print_board
    system('clear') || system('cls') # Clear the terminal screen
    @board.each { |row| puts row.map { |cell| cell == :alive ? '*' : ' ' }.join }
  end

  def tick
    new_board = Array.new(@rows) { Array.new(@cols) }

    @board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        neighbors = count_neighbors(i, j)
        new_board[i][j] = cell == :alive ? update_living_cell(neighbors) : update_dead_cell(neighbors)
      end
    end

    @board = new_board
  end

  private

  def count_neighbors(row, col)
    neighbors = 0

    (row - 1..row + 1).each do |i|
      (col - 1..col + 1).each do |j|
        next if i == row && j == col
        neighbors += 1 if valid_position?(i, j) && @board[i][j] == :alive
      end
    end

    neighbors
  end

  def update_living_cell(neighbors)
    neighbors.between?(2, 3) ? :alive : :dead
  end

  def update_dead_cell(neighbors)
    neighbors == 3 ? :alive : :dead
  end

  def valid_position?(row, col)
    row.between?(0, @rows - 1) && col.between?(0, @cols - 1)
  end
end

# Example usage
rows = 20
cols = 80
game = GameOfLife.new(rows, cols)

loop do
  begin
    game.print_board
    sleep 0.5
    game.tick
  rescue Interrupt
    puts "\nGame terminated by user."
    break
  end
end