# frozen_string_literal: true

class Plugins
  attr_reader :local, :home

  def initialize(local:, home:)
    @local = local
    @home = home
  end

  def install!
    Brew.bundle!(file: File.join(local, "Brewfile"))
    install_oh_my_zsh!
    setup_powerlevel10k!
    install_git_open!
    install_zsh_autosuggestions!
    install_zsh_syntax_highlighting!
    install_history_sync!
    install_fzf!
    install_yarn!
  end

  private

  ZSH_FOLDER = Command.new("echo ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}").get_stdout.freeze

  def install_oh_my_zsh!
    Command.new("sh -c \"$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"").run!
  end

  def setup_powerlevel10k!
    Git.new(repo: "https://github.com/romkatv/powerlevel10k.git", path: "#{ZSH_FOLDER}/themes/powerlevel10k").clone!
  end

  def install_git_open!
    Git.new(repo: "https://github.com/paulirish/git-open.git", path: "#{ZSH_FOLDER}/plugins/git-open").clone!
  end

  def install_zsh_autosuggestions!
    Git.new(repo: "https://github.com/zsh-users/zsh-autosuggestions", path: "#{ZSH_FOLDER}/plugins/zsh-autosuggestions").clone!
  end

  def install_zsh_syntax_highlighting!
    Git.new(repo: "https://github.com/zsh-users/zsh-syntax-highlighting.git", path: "#{ZSH_FOLDER}/plugins/zsh-syntax-highlighting").clone!
  end

  def install_history_sync!
    Git.new(repo: "https://github.com/wulfgarpro/history-sync.git", path: "#{ZSH_FOLDER}/plugins/history-sync").clone!
  end

  def install_fzf!
    Git.new(repo: "https://github.com/junegunn/fzf.git", path: "#{home}/.fzf").clone!
    Command.new("#{home}/.fzf/install --all").run!
  end

  def install_yarn!
    Command.new("npm install --global yarn").run!
  end
end
