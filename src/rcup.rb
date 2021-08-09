# frozen_string_literal: true

class Rcup
  attr_reader :dotfiles_dir, :dotfiles_local_dir

  def initialize(dotfiles_dir:, dotfiles_local_dir:)
    @dotfiles_dir = dotfiles_dir
    @dotfiles_local_dir = dotfiles_local_dir
  end

  def execute!
    if rcup_installed? && repo_existed?
      execute_recup!
    else
      puts "Skipped."
    end
  end

  private

  def rcup_installed?
    Command.new("which rcup").runnable?
  end

  def repo_existed?
    File.directory?(dotfiles_dir) && File.directory?(dotfiles_local_dir)
  end

  def execute_recup!
    Command.new("env RCRC=$HOME/dotfiles/rcrc rcup").run!
  end
end
