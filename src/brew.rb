# frozen_string_literal: true

class Brew
  class << self
    include Common

    attr_accessor :with_prefix

    def prefix
      case os_name
      when "Linux"
        ["${HOME}/.linuxbrew", "/home/linuxbrew/.linuxbrew"].detect {
          |p| Command.new("which #{p}/bin/brew").runnable? }
      when "macOS"
        os_machine == "arm64" ? "/opt/homebrew" : "/usr/local"
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

    def bundle!(file:)
      # Update Homebrew recipes
      self.exec! :update

      # Install all our dependencies with bundle
      self.exec! :tap, "homebrew/bundle"
      Command.new("#{with_prefix} bundle --file=#{file}").run!(raise_error: false)
    end

    def exec!(*args)
      command = args.unshift(with_prefix).join(" ")
      Command.new(command).run!
    end
  end
end
