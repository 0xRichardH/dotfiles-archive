# frozen_string_literal: true

class Plugins
  def install!
    switch_to_zsh!
    install_brew!
    install_hub!
    setup_powerlevel10k!
    install_git_open!
    install_zsh_autosuggestions!
    install_zsh_syntax_highlighting!
    install_overcommit!
    install_dip!
    install_asdf!
  end

  private

  def switch_to_zsh!
    if system("which zsh")
      system("zsh", exception: true)
    end
  end

  def install_brew!
    unless Brew.installed?
      Brew.install!
    end
  end

  def install_hub!
    Brew.exec! "install", "hub"
  end

  def setup_powerlevel10k!
    system "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k", exception: true
  end

  def install_git_open!
    Git.new(repo: "https://github.com/paulirish/git-open.git", path: "$ZSH_CUSTOM/plugins/git-open").clone!
  end

  def install_zsh_autosuggestions!
    Git.new(repo: "https://github.com/zsh-users/zsh-autosuggestions", path: "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions").clone!
  end

  def install_zsh_syntax_highlighting!
    Git.new(repo: "https://github.com/zsh-users/zsh-syntax-highlighting.git", path: "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting").clone!
  end

  def install_overcommit!
    system "gem install overcommit", exception: true
  end

  def install_dip!
    system "gem install dip", exception: true
  end

  def install_asdf!
    Brew.exec! "install", "asdf"
  end
end
