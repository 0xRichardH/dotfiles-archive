# frozen_string_literal: true

class Brew
  class << self
    def installed?
      system "which brew"
    end

    def install!
      homebrew_prefix = ENV["HOMEBREW_PREFIX"]

      if system("/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"", exception: true)
        system "echo 'eval \"$(#{homebrew_prefix}/bin/brew shellenv)\"' >> /home/codespace/.profile", exception: true
        system "eval \"$(#{homebrew_prefix}/bin/brew shellenv)\"", exception: true
      end
    end

    def exec!(*args)
      system "brew", *args, exception: true
    end
  end
end
