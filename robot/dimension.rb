module RoboMachine
  class Dimension
    attr_reader :width, :height, :size

    def initialize(options={})
      default_size = 4
      @size   = are_valid? options[:size]   || default_size
      @width  = are_valid? options[:width]  || default_size
      @height = are_valid? options[:height] || default_size
    end

    private

    def are_valid?(size)
      return nil unless size 
      size.abs 
    end

  end
end
