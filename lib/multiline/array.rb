module Multiline
  class Array < ::Array
    def join(sep = $,, align: :center)
      max_row = self.max{|str| str.row }.row
      buf = Multiline::String.new("", max_row)
      self.each_with_index do |str, index|
        case str
        when ::String
          buf.concat(Multiline::String.new(str), align: align)
        when Multiline::String
          buf.concat(str, align: align)
        end
        break if index == (self.length - 1)

        case sep
        when ::String
          buf.concat(Multiline::String.new(sep), align: align)
        when Multiline::String
          buf.concat(sep, align: align)
        end
      end
      buf
    end
  end
end
