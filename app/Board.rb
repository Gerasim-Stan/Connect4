require "matrix"
require "pp"

class Board < Matrix

  def self.construct(width, height)
    Board.build(height, width) {"."}
  end

  def drop_coin(column, sign)
    height.times do |y|
      row = height-1-y
      if self[column, row] == "."
        self[column, row] = sign
        break
      end
    end
  end

  def column_full?(column)
    height.times { |row| return false if self[column, row] == "." }
    true
  end

  def full?
    width.times { |column| return false unless column_full?(column) }
    true
  end

  def []=(y, x, e)
    super(x, y, e)
  end

  def [](y, x)
    super(x, y)
  end

  def simple_render
    output = ''
    self.each_with_index do |e, row, col|
      output += "#{e}"
      output += "\n" if col == width-1
    end
    output
  end
  
  def render
    output = ''
    self.each_with_index do |e, row, col|
      output += " \e[32mX\e[0m " if e == 'X'
      output += " \e[31mO\e[0m " if e == 'O'
      output += " . " if e == '.'
      output += "\n"  if col == width - 1
    end
    output += width.times.reduce(' ') { |result, width| result += "#{width + 1}  "} + "\n"
  end

  alias_method :to_s, :render
  alias_method :width, :column_count
  alias_method :height, :row_count
end
