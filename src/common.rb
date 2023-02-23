# frozen_string_literal: true

module Common
  def linux?
    os_name == "Linux"
  end

  def os_name
    case Command.new("uname").get_stdout
    when "Linux"
      "Linux"
    when "Darwin"
      "macOS"
    else
      "Unknown"
    end
  end

  def os_machine
    Command.new("uname -m").get_stdout
  end
end
