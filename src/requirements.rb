# frozen_string_literal: true

class Requirements
  def install!
    switch_to_zsh!
    install_brew!
  end

  private

  def switch_to_zsh!
    if system("which zsh")
      system("zsh")
    end
  end

  def install_brew!
    unless Brew.installed?
      Brew.install!
    end
  end
end
