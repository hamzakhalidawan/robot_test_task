module RoboMachine
  class Robot
    attr_reader :dimension, :direction_compass, :x, :y, :direction

    def initialize(options={})
      @dimension   = options[:dimension]   || RoboMachine::Dimension.new
      @direction_compass = options[:direction_compass] || Direction.new
      @x, @current_y, @direction = 0, 0, 0 # direction 0 means north
    end

    def place(x,y, value = direction)
      if can_i_move?(x,y)
        @x = x
        @y = y
        @direction = value 
        report 
      else
        "Attempt to move into an invalid position"
      end
    end

    # move a step into the current direction
    def move(*_)
      dir       = direction_compass.to_direction(direction)
      new_value = direction_compass.direction[dir.to_sym]

      place(x + new_value[:x], y + new_value[:y])
    end

    # rotate right
    def right(*_)
      new_direction = direction_compass.rotate :right

      place(x, y, direction + new_direction)
    end

    # rotate left
    def left(*_)
      new_direction = direction_compass.rotate :left
      
      place(x, y, direction + new_direction)
    end

    # print x,y, direction
    def report(*_)
      [x, y, direction_compass.to_direction(direction).to_s.upcase]
    end

    def quit(*_)
      exit! # so you can close the game
    end

    # return true if the attemped new x,y is in the array of valid coordinates
    def can_i_move?(x, y)
      x, y = x.to_i, y.to_i
      ( x >= 0 && x <= dimension.width  ) && ( y >= 0 && y <= dimension.height )
    end

    # The Robot itself will complain if he doesn't
    # know how to perform an action
    def method_missing(undefined_meth_yet,*args,&block)
      "#{self.class.to_s} doesn't know how to perform :#{undefined_meth_yet}"
    end

  end
end
