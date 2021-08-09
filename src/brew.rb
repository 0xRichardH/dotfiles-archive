# frozen_string_literal: true
class Brew
  class << self
    attr_accessor :with_prefix

    def installed?
      system "which brew"
    end

    def install!
      if self.installed?
        self.with_prefix = `which brew`

        puts "Skipped.Homebrew is already installed."
        return
      end

      if system("/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"", exception: true)
        self.with_prefix = "#{ENV["HOMEBREW_PREFIX"]}/bin/brew"
        self.config!
      end
    end

    def config!
      if self.with_prefix
        system "echo 'eval \"$(#{with_prefix} shellenv)\"' >> /home/codespace/.profile", exception: true
        system "eval \"$(#{with_prefix} shellenv)\"", exception: true
      end
    end

    def exec!(*args)
      system "brew", *args, exception: true
    end
  end
end
