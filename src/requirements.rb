# frozen_string_literal: true

class Requirements
  def install!
    install_brew!
    install_zsh!
    install_ohmyzsh!
  end

  private

  def install_brew!
    Brew.install!
  end

  def install_zsh!
    unless Command.new("which zsh").runnable?
      Brew.exec! :install, :zsh
    end
  end

  def install_ohmyzsh!
    unless Command.new("echo $ZSH").runnable?
      Command.new("sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"").run!
    end
  end
end
