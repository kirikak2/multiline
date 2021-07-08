require "unicode/display_width"
require "unicode/emoji"
require "multiline/version"

require "multiline/string"
require "multiline/array"

module Multiline
  def self.config=(config)
    @config = config
  end

  def self.config
    @config
  end

  class Error < StandardError; end
  class Configure
    attr_accessor :display_width_ambiguous, :display_width_overwrite

    def initialize
      self.display_width_ambiguous = 1
      self.display_width_overwrite = {}
    end
  end
end

Multiline.config = Multiline::Configure.new
