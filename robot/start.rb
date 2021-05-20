module RoboMachine
  class Start
    attr_reader :machine, :name, :interpret
    # saving command issued by human in order
    # to be able to create a kind of "reverse" method in the future
    attr_accessor :cmd, :cmd_x, :cmd_y, :cmd_f

    def initialize(options={})
      @dimension  =  options[:dimension] || RoboMachine::Dimension.new
      @machine  =  options[:machine] || RoboMachine::Robot.new({dimension: @dimension, direction: @direction})
      @interpret =  Interpret.new
      @name   =  options[:name] || object_id
      @cmd, @cmd_x, @cmd_y, @cmd_f = :report, 0, 0, 0
      @allowed_actions = machine.methods(false)
    end

    # should not be able to call other method except from those defined in the Class
    def get_move(cmd)
      @cmd, @cmd_x, @cmd_y, @cmd_f = interpret.parse(cmd)
      # here we should check that the method that we are sending to the object is actually defined as
      machine.send(@cmd, @cmd_x.to_i, @cmd_y.to_i, @cmd_f.to_i) # dangerous code
    end

  end
end
