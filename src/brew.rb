# frozen_string_literal: true

class Brew
  class << self
    def installed?
      system "which brew"
    end

    def install!
      system("/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
    end

    def exec!(*args)
      system "echo ${HOMEBREW_PREFIX} brew", *args
    end
  end
end
