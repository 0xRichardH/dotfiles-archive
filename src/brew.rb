# frozen_string_literal: true
class Brew
  class << self
    attr_accessor :with_prefix

    def prefix
      case Command.new("uname").get_stdout
      when "Linux"
        ["${HOME}/.linuxbrew", "/home/linuxbrew/.linuxbrew"].detect {
          |p| Command.new("which #{p}/bin/brew").runnable? }
      when "Darwin"
        Command.new("uname -m").get_stdout == "arm64" ? "/opt/homebrew" : "/usr/local"
      else
        raise "Homebrew is only supported on macOS and Linux."
      end
    end

    def installed?
      Command.new("which brew").runnable?
    end

    def install!
      if self.installed?
        self.with_prefix = Command.new("which brew").get_stdout

        puts "Skipped.Homebrew is already installed."
        return
      end

      Command.new("/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"").run!

      self.with_prefix = "#{self.prefix}/bin/brew"
    end

    def exec!(*args)
      command = args.unshift(with_prefix).join(" ")
      Command.new(command).run!
    end
  end
end
