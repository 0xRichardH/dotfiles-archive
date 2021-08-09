# frozen_string_literal: true

class Rcm
  attr_reader :version

  def initialize(version:)
    @version = version
  end

  def install!
    if installed?
      puts "Skipped. The rcm has already installed."
      return
    end

    Brew.installed? ? install_from_brew! : install_from_source!
  end

  private

  def installed?
    Command.new("which rcup").runnable?
  end

  def install_from_brew!
    Brew.exec! :install, :rcm
  end

  def install_from_source!
    Command.new(<<~BASH).run!
      curl -LO https://thoughtbot.github.io/rcm/dist/rcm-#{version}.tar.gz &&

      tar -xvf rcm-#{version}.tar.gz &&
      cd rcm-#{version} &&

      ./configure &&
      make &&
      sudo make install
    BASH
  end
end
