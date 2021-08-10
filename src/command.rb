# frozen_string_literal: true

class Command
  attr_reader :command

  def initialize(command)
    @command = command
  end

  def run!(raise_error: true)
    if !!raise_error
      system command, exception: true
    else
      system command
    end
  end

  def runnable?
    system command
  end

  def get_stdout
    IO.popen(command) { |f| f.gets&.chomp }
  end
end
