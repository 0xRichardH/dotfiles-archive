# frozen_string_literal: true

class Plugins
  def install!
    Brew.bundle!
    setup_powerlevel10k!
    install_git_open!
    install_zsh_autosuggestions!
    install_zsh_syntax_highlighting!
    install_fzf!
    install_default_gems!
  end

  private

  ZSH_FOLDER = Command.new("echo ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}").get_stdout.freeze

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

  def install_fzf!
    Git.new(repo: "https://github.com/junegunn/fzf.git", path: "~/.fzf")
    Command.new("~/.fzf/install").run!
  end

  def install_default_gems!
    default_gems_file = File.join(ENV["HOME"], ".default-gems")

    unless File.exist?(default_gems_file)
      raise "Skipped. The file #{default_gems_file} doesn't exist."
    end

    File.readlines(default_gems_file).each do |name|
      Command.new("gem install #{name.chomp}").run!
    end
  end
end
