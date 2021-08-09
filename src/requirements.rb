# frozen_string_literal: true

class Requirements
  def install!
    install_brew!
    switch_to_zsh!
    install_ohmyzsh!
  end

  private

  def install_brew!
    Brew.install!
  end

  def switch_to_zsh!
    unless system("which zsh")
      Brew.exec! "install", "zsh"
    end

    system("zsh", exception: true)
  end

  def install_ohmyzsh!
    system "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"", exception: true
  end
end
