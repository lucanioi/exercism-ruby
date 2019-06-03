
class Simulator
  COMMANDS = {
    'R' => :turn_right,
    'L' => :turn_left,
    'A' => :advance
  }

  def instructions(commands)
    commands.chars.map do |command|
      COMMANDS[command]
    end
  end

  def place(robot, placement)
    robot.tap do |r|
      r.at(placement[:x], placement[:y])
      r.orient(placement[:direction])
    end
  end

  def evaluate(robot, commands)
    robot.tap do |r|
      instructions(commands).each do |instruction|
        r.send(instruction)
      end
    end
  end
end
