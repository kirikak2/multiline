module Multiline
  class String
    attr_reader :row, :col, :buf
    def initialize(str = "")
      @buf = str.split(/\n/)
      @row = @buf.count || 0
      @col = @buf.map{|line| Unicode::DisplayWidth.of(line,
                                                      Multiline.config.display_width_ambiguous,
                                                      Multiline.config.display_width_overwrite) }.max || 0
      @buf = @buf.map{|line| line + " " * (@col - Unicode::DisplayWidth.of(line,
                                                                           Multiline.config.display_width_ambiguous,
                                                                           Multiline.config.display_width_overwrite)) }
    end

    def +(other)
      buf = Multiline::String.new
      buf.concat(self, other)
      buf
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

          for index in 0...row do
            buf[index] ||= ""
            line = buf[index]
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
