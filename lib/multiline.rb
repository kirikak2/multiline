require "unicode/display_width"
require "unicode/emoji"
require "multiline/version"

module Multiline
  class Error < StandardError; end

  class String
    attr_reader :row, :col, :buf
    def initialize(str = "")
      @buf = str.split(/\n/)
      @row = @buf.count
      @col = @buf.map{|line| Unicode::DisplayWidth.of(line) }.max
      @buf = @buf.map{|line| line + " " * (@col - Unicode::DisplayWidth.of(line)) }
    end

    def concat(*arguments, align: :center)
      arguments.each do |arg|
        @col += arg.col
        @row = [@row, arg.row].max
        case arg
        when ::String
        when ::Multiline::String
          case align
          when :top
            start_row = 0
            end_row = arg.row
          when :center
            start_row = (@row - arg.row) / 2
            end_row = (@row + arg.row) / 2
          when :bottom
            start_row = @row - arg.row
            end_row = @row
          end

          @buf.each_with_index do |line, index|
            if index >= start_row && index < end_row
              line.concat(arg.buf[index - start_row])
            else
              line.concat(' ' * arg.col)
            end
          end
        else
          raise ArgumentError, "Invalid string"
        end
      end
      self.to_s
    end

    def to_s
      @buf.join("\n") + "\n"
    end
  end
end
