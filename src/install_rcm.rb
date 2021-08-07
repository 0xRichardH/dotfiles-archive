# frozen_string_literal: true

class InstallRcm
  attr_reader :version

  def initialize(version:)
    @version = version
  end

  def install!
    if installed?
      puts "Skipped. The rcm has already installed."
      return
    end

    brew_installed? ? install_from_brew! : install_from_source!
  end

  private

  def installed?
    system "which rcup"
  end

  def brew_installable?
    system("which brew")
  end

  def install_from_brew!
    system "brew install rcm"
  end

  def install_from_source!
    system <<~BASH
      curl -LO https://thoughtbot.github.io/rcm/dist/rcm-#{version}tar.gz &&

      tar -xvf rcm-#{version}.tar.gz &&
      cd rcm-#{version} &&

      ./configure &&
      make &&
      sudo make install
    BASH
  end
end
